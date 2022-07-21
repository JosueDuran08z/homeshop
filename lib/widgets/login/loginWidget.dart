import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:homeshop/models/Usuario.dart';
import 'package:homeshop/repository/LoginRepository.dart';
import 'package:homeshop/widgets/misInmuebles/agregarInmuebleWidget.dart';
import 'package:homeshop/widgets/paginaInicioWidget.dart';
import 'package:homeshop/widgets/login/registrarseWidget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginWidget extends StatefulWidget {
  LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late TextEditingController _usuarioController;
  late TextEditingController _contraseniaController;
  late LoginRepository _loginRepository;
  late Usuario _usuario;
  late TextStyle _styleTextError;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _iniciarSesion() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      try {
        Future<http.Response?> response = _loginRepository.login(
            _usuarioController.text, _contraseniaController.text);

        response.then((http.Response? response) {
          var responseData = jsonDecode(response!.body);

          if (response.statusCode == 200) {
            _usuario.setUsuario(responseData);
            final Future<SharedPreferences> _prefs =
                SharedPreferences.getInstance();
            _prefs.then(
                (value) => value.setInt("idUsuario", _usuario.idUsuario!));
            final route = MaterialPageRoute(
                builder: (BuildContext context) => AgregarInmuebleWidget());
            Navigator.push(context, route);
          } else {
            mostrarSnackbar(responseData["mensaje"], Colors.red[900]);
          }
        });
      } catch (e) {
        mostrarSnackbar(
            "¡Ocurrió un error inesperado! Vuelve a intentarlo más tarde.",
            Colors.red[900]);
      }
    }
  }

  void mostrarSnackbar(String mensaje, color) {
    SnackBar snackbar = SnackBar(
      content: Text(
        mensaje,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void _mostrarRegistrarse() {
    final route = MaterialPageRoute(
        builder: (BuildContext context) => RegistrarseWidget());
    Navigator.push(context, route);
  }

  String? _validarCampo(valor, mensaje) =>
      valor!.trim().isEmpty ? mensaje : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Text(
                "Iniciar Sesión",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 30),
              Image.asset("assets/icon/logo.png", height: 150),
              const Text(
                "HomeShop",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 30),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _usuarioController,
                      decoration: const InputDecoration(
                        labelText: "Usuario",
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.person),
                      ),
                      validator: (value) =>
                          _validarCampo(value, "Introduzca el usuaurio"),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _contraseniaController,
                      decoration: const InputDecoration(
                        labelText: "Contraseña",
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.lock),
                      ),
                      validator: (value) =>
                          _validarCampo(value, "Introduzca la contraseña"),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton.icon(
                      onPressed: _iniciarSesion,
                      icon: const Icon(Icons.login),
                      label: const Text("Iniciar Sesión"),
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
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "¿Eres nuevo en HomeShop?",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: _mostrarRegistrarse,
                          child: Text(
                            "Regístrate",
                            style: TextStyle(
                              color: Colors.red[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _usuario = Usuario();
    _styleTextError =
        TextStyle(fontWeight: FontWeight.bold, color: Colors.red[700]);
    _loginRepository = LoginRepository();
    _usuarioController = TextEditingController(text: "josueduran08z@gmail.com");
    _contraseniaController = TextEditingController(text: "123");
  }
}
