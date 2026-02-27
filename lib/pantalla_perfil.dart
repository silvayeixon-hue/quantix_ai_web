import 'package:flutter/material.dart';

class PantallaPerfil extends StatefulWidget {
  const PantallaPerfil({super.key});
  @override
  State<PantallaPerfil> createState() => _PantallaPerfilState();
}

class _PantallaPerfilState extends State<PantallaPerfil> {
  bool notif = true;
  bool risksAccepted = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Center(child: CircleAvatar(radius: 40, backgroundColor: Colors.amber, child: Icon(Icons.person, size: 50, color: Colors.black))),
        const SizedBox(height: 10),
        const Center(child: Text("ID USUARIO: #QX-77890", style: TextStyle(color: Colors.grey, fontSize: 12))),
        const SizedBox(height: 30),
        const Text("AJUSTES", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber)),
        SwitchListTile(
          title: const Text("Notificaciones Push"),
          subtitle: const Text("Alertas de señales VIP y cambios de tendencia"),
          value: notif, 
          onChanged: (v) => setState(() => notif = v),
          activeColor: Colors.amber,
        ),
        const Divider(color: Colors.white10),
        const Text("LEGAL Y RIESGO", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber)),
        CheckboxListTile(
          title: const Text("Acepto los Términos de Riesgo"),
          subtitle: const Text("Entiendo que el trading conlleva riesgo de pérdida de capital."),
          value: risksAccepted, 
          onChanged: (v) => setState(() => risksAccepted = v!),
          activeColor: Colors.amber,
        ),
        const SizedBox(height: 20),
        ListTile(
          leading: const Icon(Icons.description_outlined),
          title: const Text("Política de Privacidad"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.redAccent),
          title: const Text("Cerrar Sesión", style: TextStyle(color: Colors.redAccent)),
          onTap: () {},
        ),
      ],
    );
  }
}