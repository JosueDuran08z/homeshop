import 'package:flutter/material.dart';
import 'package:homeshop/widgets/paginaInicio.dart';
import 'package:homeshop/widgets/registrarse.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _usuarioController;
  late TextEditingController _contraseniaController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _iniciarSesion() {
    final route =
        MaterialPageRoute(builder: (BuildContext context) => PaginaInicio());
    Navigator.push(context, route);
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final route =
          MaterialPageRoute(builder: (BuildContext context) => PaginaInicio());
      Navigator.push(context, route);
    }
  }

  void _mostrarRegistrarse() {
    final route =
        MaterialPageRoute(builder: (BuildContext context) => Registrarse());
    Navigator.push(context, route);
  }

  String? _validarCampo(valor, mensaje) =>
      valor!.trim().isEmpty ? mensaje : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
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
    );
  }

  @override
  void initState() {
    super.initState();
    _usuarioController = TextEditingController();
    _contraseniaController = TextEditingController();
  }
}
