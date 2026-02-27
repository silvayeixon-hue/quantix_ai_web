import 'package:flutter/material.dart';

class PantallaVIP extends StatelessWidget {
  final bool isVIP;
  const PantallaVIP({super.key, required this.isVIP});

  @override
  Widget build(BuildContext context) {
    if (!isVIP) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_outline, size: 80, color: Colors.amber),
            const SizedBox(height: 20),
            const Text("CONTENIDO EXCLUSIVO VIP", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text("Accede a señales con más del 80% de probabilidad y alertas de liquidez institucional.", textAlign: TextAlign.center),
            ),
            ElevatedButton(
              onPressed: () {}, 
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              child: const Text("SUSCRIBIRSE AHORA", style: TextStyle(color: Colors.black)),
            )
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text("SEÑALES VIP ACTIVAS", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 20),
        _buildSignalCard("BTCUSDT", "LONG", "89%", "52,450.00"),
        _buildSignalCard("ETHUSDT", "SHORT", "82%", "2,840.10"),
      ],
    );
  }

  Widget _buildSignalCard(String asset, String dir, String prob, String price) {
    Color c = dir == "LONG" ? Colors.greenAccent : Colors.redAccent;
    return Card(
      color: const Color(0xFF181A20),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: c.withOpacity(0.2), child: Icon(Icons.bolt, color: c)),
        title: Text(asset, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("ENTRADA ESTIMADA: $price"),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(dir, style: TextStyle(color: c, fontWeight: FontWeight.bold)),
            Text(prob, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}