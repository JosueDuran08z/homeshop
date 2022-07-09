import 'package:flutter/material.dart';

class AgregarCitaWidget extends StatefulWidget {
  const AgregarCitaWidget({Key? key}) : super(key: key);

  @override
  State<AgregarCitaWidget> createState() => _AgregarCitaWidgetState();
}

class _AgregarCitaWidgetState extends State<AgregarCitaWidget> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextStyle textStylePregunta = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
    color: Colors.grey[800],
  );



  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
