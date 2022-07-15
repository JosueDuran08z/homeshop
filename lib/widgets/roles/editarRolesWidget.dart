import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:homeshop/widgets/roles/rolesWidget.dart';
import 'package:image_picker/image_picker.dart';

class EditarRolWidget extends StatefulWidget {
  EditarRolWidget(this.id, {Key? key}) : super(key: key);
  int id;
  @override
  State<EditarRolWidget> createState() => _EditarRolWidgetState(this.id);
}

class _EditarRolWidgetState extends State<EditarRolWidget> {
  _EditarRolWidgetState(this.id);
  int id;

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

  void _editarRol() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Rol"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nombreController,
                  decoration: const InputDecoration(
                    labelText: "Nombre",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.map),
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
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: _editarRol,
                  icon: const Icon(Icons.save),
                  label: const Text("Guardar Cambios"),
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
    _nombreController = TextEditingController(text: "Vendedor");
    _descripcionController = TextEditingController(
        text: "Este rol puede gestionar propiedades y ponerlas en venta");
  }
}
