import 'package:flutter/material.dart';
import 'package:homeshop/widgets/buscarInmuebles/buscarInmueblesWidget.dart';
import 'package:homeshop/widgets/gestionar/gestionarWidget.dart';
import 'package:homeshop/widgets/gestionar/miCuenta.dart';
import 'package:homeshop/widgets/inmuebles/inmueblesWidget.dart';
import 'package:homeshop/widgets/misCitas/citasWidget.dart';
import 'package:homeshop/widgets/misInmuebles/editarInmuebleWidget.dart';
import 'package:homeshop/widgets/misInmuebles/misInmueblesWidget.dart';

class PaginaInicioWidget extends StatefulWidget {
  PaginaInicioWidget({Key? key}) : super(key: key);

  @override
  State<PaginaInicioWidget> createState() => _PaginaInicioWidgetState();
}

class _PaginaInicioWidgetState extends State<PaginaInicioWidget> {
  int paginaActual = 0;
  List<Widget> paginas = [
    InmueblesWidget(),
    BuscarInmueblesWidget(),
    CitasWidget(),
    EditarInmuebleWidget(1),
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
            label: "Inmuebles",
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
            label: "Mis Inmuebles",
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
