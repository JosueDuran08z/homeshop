import 'package:flutter/material.dart';

class Buscar extends StatefulWidget {
  Buscar({Key? key}) : super(key: key);

  @override
  State<Buscar> createState() => _BuscarState();
}

class _BuscarState extends State<Buscar> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Buscar"));
  }
}
