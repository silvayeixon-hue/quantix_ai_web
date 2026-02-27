import 'package:flutter/material.dart';

class PantallaAnalisis extends StatelessWidget {
  const PantallaAnalisis({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFF0B0E11),
      child: ListView(
        children: [
          const Text("ANÁLISIS TÉCNICO IA", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 20),
          _buildPilar("TENDENCIA (EMA 90)", "BUSCANDO REVERSIÓN", Colors.blueAccent, 0.7),
          _buildPilar("AGOTAMIENTO (RSI)", "ZONA DE SOBRECOMPRA", Colors.orangeAccent, 0.9),
          _buildPilar("VOLUMEN", "ACUMULACIÓN INSTITUCIONAL", Colors.purpleAccent, 0.4),
          _buildPilar("PRICE ACTION", "RECHAZO EN MECHAS", Colors.greenAccent, 0.8),
          const SizedBox(height: 30),
          const Divider(color: Colors.white10),
          const Text("CONSOLA DE CÁLCULO (LOGS)", style: TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),
            child: const Text(
              "> Analizando 100 velas...\n> Detectada liquidez minorista en SHORT\n> Multiplicador institucional activado (x1.5)\n> Probabilidad final calculada: 82% LONG",
              style: TextStyle(fontFamily: 'monospace', color: Colors.green, fontSize: 11),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPilar(String title, String desc, Color color, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              Text(desc, style: TextStyle(fontSize: 10, color: color)),
            ],
          ),
          const SizedBox(height: 5),
          LinearProgressIndicator(value: value, color: color, backgroundColor: Colors.white10),
        ],
      ),
    );
  }
}