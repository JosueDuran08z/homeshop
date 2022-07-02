import 'package:flutter/material.dart';

class MiCuentaWidget extends StatefulWidget {
  MiCuentaWidget({Key? key}) : super(key: key);

  @override
  State<MiCuentaWidget> createState() => _MiCuentaWidgetState();
}

class _MiCuentaWidgetState extends State<MiCuentaWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Mi Cuenta"));
  }
}
