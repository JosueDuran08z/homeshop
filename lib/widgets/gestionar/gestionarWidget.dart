import 'package:flutter/material.dart';

class GestionarWidget extends StatefulWidget {
  const GestionarWidget({Key? key}) : super(key: key);

  @override
  _GestionarWidgetState createState() => _GestionarWidgetState();
}

class _GestionarWidgetState extends State<GestionarWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(child: const Text("Gestionar"));
  }
}
