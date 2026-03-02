import 'package:flutter/material.dart';

class PantallaOperar extends StatelessWidget {
  const PantallaOperar({super.key});

  @override
  Widget build(BuildContext context) {
    // Cálculo basado en tu Matriz de Pesos
    double prob = 0;
    bool mecha = true; // +30%
    bool retailAtrapado = true; // +25%
    bool ema90 = true; // +20%
    if (mecha) prob += 30;
    if (retailAtrapado) prob += 25;
    if (ema90) prob += 20;
    // ... suma total simula un 75-85%

    return Scaffold(
      appBar: AppBar(title: const Text("BTCUSDT | IA ACTIVA"), backgroundColor: Colors.transparent),
      body: Column(
        children: [
          const LinearProgressIndicator(value: 0.68, color: Colors.green, backgroundColor: Colors.red),
          const SizedBox(height: 40),
          Center(
            child: Container(
              padding: const EdgeInsets.all(50),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  if (prob >= 80) BoxShadow(color: Colors.amber.withOpacity(0.4), blurRadius: 20, spreadRadius: 10)
                ],
                border: Border.all(color: prob >= 80 ? Colors.amber : Colors.greenAccent, width: 3),
              ),
              child: Text("${prob.toInt()}%", style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text("SISTEMA DE LIQUIDEZ INSTITUCIONAL", style: TextStyle(color: Colors.grey, fontSize: 10)),
          ),
        ],
      ),
    );
  }
}