import 'package:flutter/material.dart';

class MisCitasWidget extends StatefulWidget {
  MisCitasWidget({Key? key}) : super(key: key);

  @override
  State<MisCitasWidget> createState() => _MisCitasWidgetState();
}

class _MisCitasWidgetState extends State<MisCitasWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(child: const Text("Mis Citas"));
  }
}
