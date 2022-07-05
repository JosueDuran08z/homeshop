import 'dart:io';
import 'package:flutter/material.dart';
class AgregarRolWidget extends StatefulWidget {
  const AgregarRolWidget({Key? key}) : super(key: key);

  @override
  State<AgregarRolWidget> createState() => _AgregarRolWidgetState();
}

class _AgregarRolWidgetState extends State<AgregarRolWidget> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextStyle textStylePregunta = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
    color: Colors.grey[800],
  );

  late TextEditingController _nombreController;
  late TextEditingController _descripcionController;
  String? _validarCampo(valor, mensaje) =>
      valor!.trim().isEmpty ? mensaje : null;

  void _agregarRol() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agregar Rol"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nombreController,
                  decoration: const InputDecoration(
                    labelText: "Nombre",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.drive_file_rename_outline),
                  ),
                  validator: (value) =>
                      _validarCampo(value, "Introduzca el nombre"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _descripcionController,
                  decoration: const InputDecoration(
                    labelText: "Descripción",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.description),
                  ),
                  maxLines: 4,
                  validator: (value) =>
                      _validarCampo(value, "Introduzca la descripción"),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _agregarRol,
                  icon: const Icon(Icons.add),
                  label: const Text("Agregar Rol"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[700],
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 15,
                      right: 20,
                      bottom: 15,
                    ),
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController();
    _descripcionController = TextEditingController();
  }
}
