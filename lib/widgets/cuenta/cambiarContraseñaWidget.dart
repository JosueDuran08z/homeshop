import 'package:flutter/material.dart';

class CambiarContrasenaWidget extends StatefulWidget {
  const CambiarContrasenaWidget({Key? key}) : super(key: key);

  @override
  State<CambiarContrasenaWidget> createState() => _CambiarContrasenaWidgetState();
}

class _CambiarContrasenaWidgetState extends State<CambiarContrasenaWidget> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextStyle textStylePregunta = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
    color: Colors.grey[800],
  );

  late TextEditingController _nuevaContrasenaController;
  late TextEditingController _repetircontrasenaController;

  String? _validarCampo(valor, mensaje) =>
      valor!.trim().isEmpty ? mensaje : null;

  void _agregarContrasena() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi cuenta - Cambiar contraseña"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nuevaContrasenaController,
                  decoration: const InputDecoration(
                    labelText: "Nueva contraseña",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.password),
                  ),
                  validator: (value) =>
                      _validarCampo(
                          value, "Introduzca una nueva contraseña"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _repetircontrasenaController,
                  decoration: const InputDecoration(
                    labelText: "Repetir contraseña",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.password),
                  ),
                  validator: (value) =>
                      _validarCampo(
                          value, "Repita la nueva contraseña"),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _agregarContrasena,
                  icon: const Icon(Icons.save),
                  label: const Text("Guardar contraseña"),
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
                      borderRadius: BorderRadius.circular(15),
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
    _nuevaContrasenaController = TextEditingController();
    _repetircontrasenaController = TextEditingController();
  }
}
