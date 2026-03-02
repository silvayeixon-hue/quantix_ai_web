import 'package:flutter/material.dart';

class PantallaPerfil extends StatelessWidget {
  const PantallaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AJUSTES")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(backgroundColor: Color(0xFFF0B90B), radius: 30, child: Icon(Icons.person, color: Colors.black)),
            const Text("ID USUARIO: #QX-77890"),
            const Divider(),
            SwitchListTile(value: true, onChanged: (v){}, title: const Text("Notificaciones Push")),
            CheckboxListTile(value: true, onChanged: (v){}, title: const Text("Acepto los Términos de Riesgo")),
            const ListTile(leading: Icon(Icons.description), title: Text("Política de Privacidad")),
            const Spacer(),
            TextButton(onPressed: (){}, child: const Text("Cerrar Sesión", style: Colors.red)),
          ],
        ),
      ),
    );
  }
}