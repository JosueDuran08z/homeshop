import 'package:flutter/material.dart';

class AgregarPropiedadWidget extends StatefulWidget {
  AgregarPropiedadWidget({Key? key}) : super(key: key);

  @override
  State<AgregarPropiedadWidget> createState() => _AgregarPropiedadWidgetState();
}

class _AgregarPropiedadWidgetState extends State<AgregarPropiedadWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Center(child: Text("Agregar")),
    );
  }
}
