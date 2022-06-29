import 'package:flutter/material.dart';

class MiCuenta extends StatefulWidget {
  MiCuenta({Key? key}) : super(key: key);

  @override
  State<MiCuenta> createState() => _MiCuentaState();
}

class _MiCuentaState extends State<MiCuenta> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Mi Cuenta"));
  }
}
