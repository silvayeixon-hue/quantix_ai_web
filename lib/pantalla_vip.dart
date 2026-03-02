import 'package:flutter/material.dart';

class PantallaVIP extends StatelessWidget {
  const PantallaVIP({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SEÑALES VIP ACTIVAS")),
      body: ListView(
        children: const [
          _SignalCard("BTCUSDT", "LONG", "89%", "52,450.00"),
          _SignalCard("ETHUSDT", "SHORT", "82%", "2,840.10"),
        ],
      ),
    );
  }
}

class _SignalCard extends StatelessWidget {
  final String activo, dir, prob, precio;
  const _SignalCard(this.activo, this.dir, this.prob, this.precio);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white10,
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: Icon(Icons.bolt, color: dir == "LONG" ? Colors.green : Colors.red),
        title: Text(activo),
        subtitle: Text("ENTRADA ESTIMADA: $precio"),
        trailing: Text(prob, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
    );
  }
}