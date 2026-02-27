import 'package:flutter/material.dart';
import 'dart:ui_web' as ui;
import 'dart:html' as html;
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:pointer_interceptor/pointer_interceptor.dart';

class PantallaOperar extends StatefulWidget {
  final String asset;
  final double retailLongSentiment; // Recibimos el sentimiento desde el Main

  const PantallaOperar({
    super.key, 
    required this.asset, 
    required this.retailLongSentiment
  });

  @override
  State<PantallaOperar> createState() => _PantallaOperarState();
}

class _PantallaOperarState extends State<PantallaOperar> {
  int longP = 50, shortP = 50;
  String _selectedTf = "1h";
  Timer? _timer;
  String _viewId = "";

  @override
  void initState() {
    super.initState();
    _startLiveEngine();
  }

  void _startLiveEngine() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 10), (t) => _fetchData());
    _fetchData();
  }

  Future<void> _fetchData() async {
    final bool isCrypto = widget.asset.endsWith("USDT");
    // Simulación de endpoint para Cripto/Bolsa
    final url = Uri.parse('https://api.binance.com/api/v3/klines?symbol=${isCrypto ? widget.asset : "BTCUSDT"}&interval=$_selectedTf&limit=100');

    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        List data = jsonDecode(res.body);
        double close = double.parse(data.last[4]);
        double open = double.parse(data.last[1]);
        double low = double.parse(data.last[3]);
        
        double score = 50.0; 

        // 1. LÓGICA DE EMA 90 (REVERSIÓN INSTITUCIONAL)
        double ema90 = 0;
        for(int i=10; i<100; i++) ema90 += double.parse(data[i][4]); 
        ema90 /= 90;
        
        if (close < ema90 * 0.985) score += 15; // Extensión baja
        if (close > ema90 * 1.015) score -= 15; // Extensión alta

        // 2. RSI DE AGOTAMIENTO (20/80)
        // (Simplificado para el ejemplo de motor predictivo)
        if (close > open) score -= 5; else score += 5;

        // 3. 🏦 FILTRO DE CONTRATENDENCIA INSTITUCIONAL (CAZA DE LIQUIDEZ)
        // Si el sentimiento retail es extremo (>80% Long), la IA busca el Short.
        if (widget.retailLongSentiment > 80) {
          score -= 25; // Penalizamos el Long porque hay demasiada liquidez abajo
        } else if (widget.retailLongSentiment < 20) {
          score += 25; // Penalizamos el Short porque hay liquidez arriba
        }

        // 4. MECHAS DE RECHAZO (ACCIÓN DE PRECIO)
        double lowerWick = (close < open) ? close - low : open - low;
        if (lowerWick > (close - open).abs() * 1.5) score += 10;

        setState(() {
          longP = score.clamp(5, 95).toInt();
          shortP = 100 - longP;
          _updateChart();
        });
      }
    } catch (e) {
      debugPrint("Error en Motor IA: $e");
    }
  }

  void _updateChart() {
    Map<String, String> tfMap = {"1m":"1", "5m":"5", "15m":"15", "1h":"60", "4h":"240", "1d":"D"};
    String tfParam = tfMap[_selectedTf] ?? "60";
    String exchange = widget.asset.contains("USDT") ? "BINANCE:" : "NASDAQ:";
    
    _viewId = 'tv-${widget.asset}-$_selectedTf';
    
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(_viewId, (int id) => html.IFrameElement()
      ..src = 'https://s.tradingview.com/widgetembed/?symbol=$exchange${widget.asset}&interval=$tfParam&theme=dark'
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%');
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Selector de Temporalidad Protegido
        PointerInterceptor(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            color: const Color(0xFF181A20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("TF: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                DropdownButton<String>(
                  value: _selectedTf,
                  dropdownColor: const Color(0xFF181A20),
                  items: ["1m", "5m", "15m", "1h", "4h", "1d"].map((v) => 
                    DropdownMenuItem(value: v, child: Text(v, style: const TextStyle(fontSize: 12)))
                  ).toList(),
                  onChanged: (v) {
                    setState(() => _selectedTf = v!);
                    _fetchData();
                  },
                ),
              ],
            ),
          ),
        ),
        
        // Círculos de Probabilidad con efecto Glow
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildIndicator("LONG IA", longP, Colors.greenAccent),
              _buildIndicator("SHORT IA", shortP, Colors.redAccent),
            ],
          ),
        ),

        // Gráfico de TradingView
        Expanded(
          child: HtmlElementView(key: ValueKey(_viewId), viewType: _viewId),
        ),
      ],
    );
  }

  Widget _buildIndicator(String label, int value, Color color) {
    bool isVIPSignal = value >= 80;
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            if (isVIPSignal)
              Container(
                width: 80, height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 20, spreadRadius: 5)],
                ),
              ),
            SizedBox(
              width: 70, height: 70,
              child: CircularProgressIndicator(
                value: value / 100,
                color: color,
                backgroundColor: Colors.white10,
                strokeWidth: 8,
              ),
            ),
            Text("$value%", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    );
  }
}