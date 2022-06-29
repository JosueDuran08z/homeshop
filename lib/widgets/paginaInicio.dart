import 'package:flutter/material.dart';
import 'package:homeshop/widgets/buscar.dart';
import 'package:homeshop/widgets/miCuenta.dart';
import 'package:homeshop/widgets/propiedades.dart';

class PaginaInicio extends StatefulWidget {
  PaginaInicio({Key? key}) : super(key: key);

  @override
  State<PaginaInicio> createState() => _PaginaInicioState();
}

class _PaginaInicioState extends State<PaginaInicio> {
  int paginaActual = 0;
  List<Widget> paginas = [
    Propiedades(),
    Buscar(),
    MiCuenta(),
  ];

  void _cambiarPagina(index) => setState(() => paginaActual = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: paginas[paginaActual],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _cambiarPagina,
        currentIndex: paginaActual,
        items: [
          BottomNavigationBarItem(
            label: "Propiedades",
            icon: Icon(
              Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            label: "Buscar",
            icon: Icon(
              Icons.search,
            ),
          ),
          BottomNavigationBarItem(
            label: "Mi Cuenta",
            icon: Icon(
              Icons.person,
            ),
          ),
        ],
      ),
    );
  }
}
