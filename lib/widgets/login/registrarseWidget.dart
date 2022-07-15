import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:homeshop/widgets/login/loginWidget.dart';
import 'package:intl/intl.dart';

class RegistrarseWidget extends StatefulWidget {
  RegistrarseWidget({Key? key}) : super(key: key);

  @override
  State<RegistrarseWidget> createState() => _RegistrarseWidgetState();
}

class _RegistrarseWidgetState extends State<RegistrarseWidget> {
  late TextEditingController _nombreController;
  late TextEditingController _apePController;
  late TextEditingController _apeMController;
  String? fechaNacimiento;
  late TextEditingController _emailController;
  late TextEditingController _contraseniaController;
  late TextEditingController _telefonoController;
  String? tipoUsuario;
  TextStyle textLinkStyle = TextStyle(color: Colors.grey[700]);
  List<DropdownMenuItem<String>> listaTiposUsuarios = [
    const DropdownMenuItem<String>(value: "Cliente", child: Text("Cliente")),
    const DropdownMenuItem<String>(value: "Vendedor", child: Text("Vendedor")),
  ];

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _registrar() {
    /* final route = MaterialPageRoute(builder: (BuildContext context) => Login());
    Navigator.push(context, route); */
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final route =
          MaterialPageRoute(builder: (BuildContext context) => LoginWidget());
      Navigator.push(context, route);
    }
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
                "Registrarse",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 30),
              Image.asset("assets/icon/logo.png", height: 150),
              const SizedBox(height: 30),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nombreController,
                      decoration: const InputDecoration(
                        labelText: "Nombre",
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.person),
                      ),
                      validator: (value) =>
                          _validarCampo(value, "Introduzca el nombre"),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _apePController,
                      decoration: const InputDecoration(
                        labelText: "Apellido Paterno",
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.person),
                      ),
                      validator: (value) => _validarCampo(
                          value, "Introduzca el apellido paterno"),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _apeMController,
                      decoration: const InputDecoration(
                        labelText: "Apellido Materno",
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.person),
                      ),
                      validator: (value) => _validarCampo(
                          value, "Introduzca el apellido paterno"),
                    ),
                    const SizedBox(height: 20),
                    DateTimeFormField(
                        decoration: const InputDecoration(
                            labelText: "Fecha de nacimiento",
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.event_note)),
                        mode: DateTimeFieldPickerMode.date,
                        dateFormat: DateFormat("dd/MM/yyyy"),
                        validator: (date) =>
                            date == null ? "Seleccione una fecha" : null,
                        onDateSelected: (DateTime value) {
                          setState(() => fechaNacimiento =
                              value.toString().substring(0, 10));
                        }),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: "Correo electrónico",
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.email),
                      ),
                      validator: (value) => _validarCampo(
                          value, "Introduzca el correo electrónico"),
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
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _telefonoController,
                      decoration: const InputDecoration(
                        labelText: "Teléfono",
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.phone),
                      ),
                      validator: (value) =>
                          _validarCampo(value, "Introduzca el teléfono"),
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField(
                      value: tipoUsuario,
                      isExpanded: true,
                      onChanged: (String? value) =>
                          setState(() => tipoUsuario = value!),
                      items: listaTiposUsuarios,
                      decoration: const InputDecoration(
                        labelText: "Tipo de usuario",
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.person),
                      ),
                      validator: (value) => value == null
                          ? "Seleccione el tipo de usuario"
                          : null,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton.icon(
                      onPressed: _registrar,
                      icon: const Icon(Icons.login),
                      label: const Text("Registrarse"),
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
    _nombreController = TextEditingController();
    _apePController = TextEditingController();
    _apeMController = TextEditingController();
    _emailController = TextEditingController();
    _contraseniaController = TextEditingController();
    _telefonoController = TextEditingController();
  }
}
