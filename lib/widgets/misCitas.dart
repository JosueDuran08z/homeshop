import 'package:flutter/material.dart';

class MisCitas extends StatefulWidget {
  MisCitas({Key? key}) : super(key: key);

  @override
  State<MisCitas> createState() => _MisCitasState();
}

class _MisCitasState extends State<MisCitas> {
  @override
  Widget build(BuildContext context) {
    return Center(child: const Text("Mis Citas"));
  }
}
