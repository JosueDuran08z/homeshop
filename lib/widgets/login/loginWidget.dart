import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:homeshop/models/Usuario.dart';
import 'package:homeshop/repository/LoginRepository.dart';
import 'package:homeshop/widgets/paginaInicioWidget.dart';
import 'package:homeshop/widgets/login/registrarseWidget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
  String? _error;
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
            final route = MaterialPageRoute(
                builder: (BuildContext context) => PaginaInicioWidget());
            Navigator.push(context, route);
          } else {
            setState(() => _error = responseData["mensaje"]);
          }
        });
      } catch (e) {
        setState(() =>
            _error = "¡Ocurrió un error inesperado! Inténtalo más tarde.");
      }
    }
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
      body: Padding(
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
                  _error != null
                      ? Column(
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              _error!,
                              style: _styleTextError,
                            )
                          ],
                        )
                      : Container(),
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
    );
  }

  @override
  void initState() {
    super.initState();
    _usuario = Usuario();
    _styleTextError =
        TextStyle(fontWeight: FontWeight.bold, color: Colors.red[700]);
    _loginRepository = LoginRepository();
    _usuarioController = TextEditingController();
    _contraseniaController = TextEditingController();
  }
}
