import 'package:flutter/material.dart';
import 'package:homeshop/widgets/buscar.dart';
import 'package:homeshop/widgets/gestionar.dart';
import 'package:homeshop/widgets/misCitas.dart';
import 'package:homeshop/widgets/misPropiedades.dart';
import 'package:homeshop/widgets/propiedad.dart';
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
    MisCitas(),
    MisPropiedades(),
    Gestionar(),
  ];

  void _cambiarPagina(index) => setState(() => paginaActual = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: paginas[paginaActual],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _cambiarPagina,
        currentIndex: paginaActual,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 10,
        unselectedFontSize: 10,
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
            label: "Mis Citas",
            icon: Icon(
              Icons.calendar_month,
            ),
          ),
          BottomNavigationBarItem(
            label: "Mis Propiedades",
            icon: Icon(
              Icons.edit,
            ),
          ),
          BottomNavigationBarItem(
            label: "Gestionar",
            icon: Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
    );
  }
}
