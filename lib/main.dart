import 'package:flutter/material.dart';
import 'pantalla_operar.dart';
import 'pantalla_analisis.dart';
import 'pantalla_vip.dart';
import 'pantalla_perfil.dart';

void main() => runApp(const QuantixAI());

class QuantixAI extends StatelessWidget {
  const QuantixAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0B0E11),
        primaryColor: const Color(0xFFF0B90B),
      ),
      home: const BaseNavigation(),
    );
  }
}

class BaseNavigation extends StatefulWidget {
  const BaseNavigation({super.key});
  @override
  State<BaseNavigation> createState() => _BaseNavigationState();
}

class _BaseNavigationState extends State<BaseNavigation> {
  int _index = 0;
  final List<Widget> _paginas = [
    const PantallaOperar(),
    const PantallaAnalisis(),
    const PantallaVIP(),
    const PantallaPerfil(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _paginas),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFF0B90B),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.flash_on), label: 'Operar'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Análisis'),
          BottomNavigationBarItem(icon: Icon(Icons.stars), label: 'VIP'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}