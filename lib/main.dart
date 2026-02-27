// ignore_for_file: avoid_web_libraries_in_flutter
import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

// 1. IMPORTACIÓN DE LOS "BRAZOS" (Tus nuevos archivos)
import 'pantalla_operar.dart';
import 'pantalla_analisis.dart';
import 'pantalla_vip.dart';
import 'pantalla_perfil.dart';

void main() => runApp(const QuantixAI());

class QuantixAI extends StatefulWidget {
  const QuantixAI({super.key});
  @override
  State<QuantixAI> createState() => _QuantixAIState();
}

class _QuantixAIState extends State<QuantixAI> {
  // Configuración Global de la App
  bool isVIP = true; 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quantix AI Trading',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: const Color(0xFF0B0E11),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber, 
          brightness: Brightness.dark
        ),
      ),
      home: MainNavigation(isVIP: isVIP),
    );
  }
}

class MainNavigation extends StatefulWidget {
  final bool isVIP;
  const MainNavigation({super.key, required this.isVIP});
  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  String _currentAsset = "BTCUSDT";
  
  // Datos de Sentimiento para la "Caza de Liquidez"
  // 68% Long significa que la masa está comprando; la IA buscará el Short.
  double retailLongPercentage = 68.0; 

  void _updateAsset(String newAsset) => setState(() => _currentAsset = newAsset);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF181A20),
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$_currentAsset | IA ACTIVA", 
              style: const TextStyle(fontSize: 14, color: Colors.amber, fontWeight: FontWeight.bold)),
            const Text("SISTEMA DE LIQUIDEZ INSTITUCIONAL", 
              style: TextStyle(fontSize: 9, color: Colors.grey)),
          ],
        ),
        actions: [
          PointerInterceptor(
            child: IconButton(
              icon: const Icon(Icons.search, color: Colors.amber),
              onPressed: () async {
                String? r = await showSearch(context: context, delegate: AssetSearchDelegate());
                if (r != null) _updateAsset(r);
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // BARRA DE LIQUIDEZ RETAIL (MAPA DE TRAMPAS)
          PointerInterceptor(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              color: const Color(0xFF181A20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("RETAIL LONGS: ${retailLongPercentage.toInt()}%", 
                        style: const TextStyle(fontSize: 10, color: Colors.greenAccent)),
                      const Text("SENTIMIENTO DE MASA", 
                        style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.white38)),
                      Text("SHORTS: ${(100 - retailLongPercentage).toInt()}%", 
                        style: const TextStyle(fontSize: 10, color: Colors.redAccent)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: LinearProgressIndicator(
                      value: retailLongPercentage / 100,
                      backgroundColor: Colors.redAccent,
                      color: Colors.greenAccent,
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // CONECTOR DE PANTALLAS (INDEXED STACK)
          Expanded(
            child: IndexedStack(
              index: _selectedIndex, 
              children: [
                PantallaOperar(
                  asset: _currentAsset, 
                  retailLongSentiment: retailLongPercentage,
                ),
                const PantallaAnalisis(),
                PantallaVIP(isVIP: widget.isVIP),
                const PantallaPerfil(),
              ]
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber,
        backgroundColor: const Color(0xFF181A20),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.bolt), label: 'Operar'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Análisis'),
          BottomNavigationBarItem(icon: Icon(Icons.stars), label: 'VIP'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}

// BUSCADOR UNIVERSAL (CRIPTO + BOLSA)
class AssetSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, String>> assets = [
    {"sym": "BTCUSDT", "name": "Bitcoin", "type": "CRIPTO"},
    {"sym": "ETHUSDT", "name": "Ethereum", "type": "CRIPTO"},
    {"sym": "AAPL", "name": "Apple Inc.", "type": "BOLSA"},
    {"sym": "TSLA", "name": "Tesla Motors", "type": "BOLSA"},
    {"sym": "NVDA", "name": "Nvidia Corp.", "type": "BOLSA"},
    {"sym": "GOLD", "name": "Oro / Dólar", "type": "METAL"},
  ];

  @override
  List<Widget>? buildActions(BuildContext context) => 
    [IconButton(icon: const Icon(Icons.clear), onPressed: () => query = "")];

  @override
  Widget? buildLeading(BuildContext context) => 
    IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => close(context, ""));

  @override
  Widget buildResults(BuildContext context) => buildSuggestions(context);

  @override
  Widget buildSuggestions(BuildContext context) {
    final list = assets.where((a) => a['sym']!.contains(query.toUpperCase())).toList();
    return Container(
      color: const Color(0xFF0B0E11),
      child: ListView.builder(
        itemCount: list.length, 
        itemBuilder: (c, i) => ListTile(
          leading: Icon(list[i]['type'] == "CRIPTO" ? Icons.currency_bitcoin : Icons.show_chart, color: Colors.amber),
          title: Text(list[i]['sym']!, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text("${list[i]['name']} | ${list[i]['type']}"),
          onTap: () => close(context, list[i]['sym']!),
        ),
      ),
    );
  }
}