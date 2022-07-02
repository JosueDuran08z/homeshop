import 'package:flutter/material.dart';

class BuscarPropiedadesWidget extends StatefulWidget {
  BuscarPropiedadesWidget({Key? key}) : super(key: key);

  @override
  State<BuscarPropiedadesWidget> createState() =>
      _BuscarPropiedadesWidgetState();
}

class _BuscarPropiedadesWidgetState extends State<BuscarPropiedadesWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Buscar"));
  }
}
