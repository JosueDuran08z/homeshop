import 'package:flutter/material.dart';

class EditarPropiedadWidget extends StatefulWidget {
  EditarPropiedadWidget(this.idPropiedad, {Key? key}) : super(key: key);
  int idPropiedad;

  @override
  State<EditarPropiedadWidget> createState() =>
      _EditarPropiedadWidgetState(this.idPropiedad);
}

class _EditarPropiedadWidgetState extends State<EditarPropiedadWidget> {
  _EditarPropiedadWidgetState(this.idPropiedad);
  int idPropiedad;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Center(child: Text("Editar $idPropiedad")),
    );
  }
}
