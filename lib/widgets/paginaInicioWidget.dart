import 'package:flutter/material.dart';
import 'package:homeshop/widgets/buscarPropiedades/buscarPropiedadesWidget.dart';
import 'package:homeshop/widgets/gestionar/gestionarWidget.dart';
import 'package:homeshop/widgets/gestionar/miCuenta.dart';
import 'package:homeshop/widgets/misCitas/citasWidget.dart';
import 'package:homeshop/widgets/misPropiedades/misPropiedadesWidget.dart';
import 'package:homeshop/widgets/propiedades/propiedadesWidget.dart';

class PaginaInicioWidget extends StatefulWidget {
  PaginaInicioWidget({Key? key}) : super(key: key);

  @override
  State<PaginaInicioWidget> createState() => _PaginaInicioWidgetState();
}

class _PaginaInicioWidgetState extends State<PaginaInicioWidget> {
  int paginaActual = 0;
  List<Widget> paginas = [
    PropiedadesWidget(),
    BuscarPropiedadesWidget(),
    CitasWidget(),
    MisPropiedadesWidget(),
    GestionarWidget(),
    MiCuentaWidget(),
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
