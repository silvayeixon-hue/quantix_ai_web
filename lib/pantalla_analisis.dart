import 'package:flutter/material.dart';

class PantallaAnalisis extends StatelessWidget {
  const PantallaAnalisis({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ANÁLISIS TÉCNICO IA")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _barra("TENDENCIA (EMA 90)", 0.9, Colors.blue, "BUSCANDO REVERSIÓN"),
            _barra("AGOTAMIENTO (RSI)", 0.8, Colors.orange, "ZONA DE SOBRECOMPRA"),
            _barra("VOLUMEN", 0.4, Colors.purple, "ACUMULACIÓN INSTITUCIONAL"),
            _barra("PRICE ACTION", 0.85, Colors.green, "RECHAZO EN MECHAS"),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.black,
              width: double.infinity,
              child: const Text("> Analizando velas...\n> Liquidez detectada en SHORT\n> Probabilidad final: 82% LONG", 
                style: TextStyle(color: Colors.greenAccent, fontFamily: 'monospace')),
            )
          ],
        ),
      ),
    );
  }

  Widget _barra(String t, double v, Color c, String sub) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(t), Text(sub, style: const TextStyle(fontSize: 10, color: Colors.grey))]),
        LinearProgressIndicator(value: v, color: c, minHeight: 8),
        const SizedBox(height: 15),
      ],
    );
  }
}