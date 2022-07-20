import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/services.dart';
import 'package:homeshop/models/Usuario.dart';
import 'package:homeshop/repository/LoginRepository.dart';
import 'package:homeshop/widgets/login/loginWidget.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegistrarseWidget extends StatefulWidget {
  RegistrarseWidget({Key? key}) : super(key: key);

  @override
  State<RegistrarseWidget> createState() => _RegistrarseWidgetState();
}

class _RegistrarseWidgetState extends State<RegistrarseWidget> {
  late LoginRepository _loginRepository;
  late Usuario _usuario;
  late TextEditingController _nombreController,
      _apePController,
      _apeMController,
      _emailController,
      _contraseniaController,
      _telefonoController,
      _calleController,
      _coloniaController,
      _codPostalController,
      _numIntController,
      _numExtController,
      _razonSocialController;
  String? fechaNacimiento;
  String? tipoUsuario;
  TextStyle textLinkStyle = TextStyle(color: Colors.grey[700]);
  List<DropdownMenuItem<String>> listaTiposUsuarios = [
    const DropdownMenuItem<String>(value: "Cliente", child: Text("Cliente")),
    const DropdownMenuItem<String>(value: "Vendedor", child: Text("Vendedor")),
  ];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextStyle textStylePregunta = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
    color: Colors.grey[800],
  );
  String? perfilUsuario;

  void _registrar() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      try {
        _usuario.email = _emailController.text.trim();
        _usuario.contrasenia = _contraseniaController.text.trim();
        _usuario.calle = _calleController.text.trim();
        _usuario.numInterior = _numIntController.text.trim();
        _usuario.numExterior = _numExtController.text.isEmpty
            ? null
            : _numExtController.text.trim();
        _usuario.colonia = _coloniaController.text.trim();
        _usuario.cp = int.parse(_codPostalController.text);
        _usuario.telefono = int.parse(_telefonoController.text);

        if (perfilUsuario == "particular") {
          _usuario.persona.nombre = _nombreController.text.trim();
          _usuario.persona.apePaterno = _apePController.text.trim();
          _usuario.persona.apeMaterno =
              _apeMController.text.isEmpty ? null : _apeMController.text.trim();
          _usuario.persona.fechaNacimientoInsert = fechaNacimiento;
        } else {
          _usuario.empresa.razonSocial = _razonSocialController.text.trim();
        }

        Future<http.Response?> response =
            _loginRepository.registrarse(_usuario, perfilUsuario!);

        response.then((http.Response? response) {
          var responseData = jsonDecode(response!.body);

          if (response.statusCode == 201) {
            final route = MaterialPageRoute(
                builder: (BuildContext context) => LoginWidget());
            Navigator.push(context, route);
            mostrarSnackbar(responseData["mensaje"], Colors.blue[600]);
          } else {
            String mensaje = responseData["mensaje"];

            if (response.statusCode == 409) {
              mensaje = "$mensaje Ingrese uno nuevo.";
            }

            mostrarSnackbar(mensaje, Colors.red[900]);
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
      ),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void _cambiarPerfilUsuario(String? value) =>
      setState(() => perfilUsuario = value);

  String? _validarCampo(valor, mensaje) =>
      valor!.trim().isEmpty ? mensaje : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrarse"),
      ),
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
                    Row(
                      children: [
                        Text(
                          "¿Con cuál perfil se identifica?",
                          style: textStylePregunta,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    RadioListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text(
                        "Particular (cliente o propietario de un inmueble)",
                      ),
                      value: "particular",
                      groupValue: perfilUsuario,
                      onChanged: _cambiarPerfilUsuario,
                    ),
                    RadioListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text(
                        "Profesional (Inmobiliaria o constructora)",
                      ),
                      value: "profesional",
                      groupValue: perfilUsuario,
                      onChanged: _cambiarPerfilUsuario,
                    ),
                    perfilUsuario != "particular"
                        ? Container()
                        : Column(
                            children: [
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _nombreController,
                                decoration: const InputDecoration(
                                  labelText: "Nombre",
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.person),
                                ),
                                validator: (value) => _validarCampo(
                                    value, "Introduzca el nombre"),
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
                                validator: (date) => date == null
                                    ? "Seleccione una fecha"
                                    : null,
                                onDateSelected: (DateTime value) {
                                  setState(() => fechaNacimiento =
                                      value.toString().substring(0, 10));
                                },
                              ),
                            ],
                          ),
                    perfilUsuario != "profesional"
                        ? Container()
                        : Column(
                            children: [
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _razonSocialController,
                                decoration: const InputDecoration(
                                  labelText: "Razón Social",
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.map),
                                ),
                                validator: (value) => _validarCampo(
                                    value, "Introduzca la razón social"),
                              ),
                            ],
                          ),
                    perfilUsuario == null
                        ? Container()
                        : Column(
                            children: [
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _calleController,
                                decoration: const InputDecoration(
                                  labelText: "Calle",
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.map),
                                ),
                                validator: (value) =>
                                    _validarCampo(value, "Introduzca la calle"),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _coloniaController,
                                decoration: const InputDecoration(
                                  labelText: "Colonia",
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.maps_home_work),
                                ),
                                validator: (value) => _validarCampo(
                                    value, "Introduzca la colonia"),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _numIntController,
                                      decoration: const InputDecoration(
                                        labelText: "# Interior",
                                        border: OutlineInputBorder(),
                                        suffixIcon: Icon(Icons.numbers),
                                      ),
                                      validator: (value) => _validarCampo(value,
                                          "Introduzca el número interior"),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _numExtController,
                                      decoration: const InputDecoration(
                                        labelText: "# Exterior",
                                        border: OutlineInputBorder(),
                                        suffixIcon: Icon(Icons.numbers),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _codPostalController,
                                decoration: const InputDecoration(
                                  labelText: "Código Postal",
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.location_on_outlined),
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                validator: (value) => _validarCampo(
                                    value, "Introduzca el código postal"),
                              ),
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
                                validator: (value) => _validarCampo(
                                    value, "Introduzca la contraseña"),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _telefonoController,
                                decoration: const InputDecoration(
                                  labelText: "Teléfono",
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.phone),
                                ),
                                validator: (value) => _validarCampo(
                                    value, "Introduzca el teléfono"),
                              ),
                            ],
                          ),
                    const SizedBox(height: 30),
                    perfilUsuario == null
                        ? Container()
                        : ElevatedButton.icon(
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
    _loginRepository = LoginRepository();
    _usuario = Usuario();
    _nombreController = TextEditingController(text: "Cristiano");
    _apePController = TextEditingController(text: "dos Santos");
    _apeMController = TextEditingController(text: "Aveiro");
    _emailController = TextEditingController(text: "cr7@gmail.com");
    _contraseniaController = TextEditingController(text: "123");
    _telefonoController = TextEditingController(text: "477123457");
    _calleController = TextEditingController(text: "Madeira");
    _coloniaController = TextEditingController(text: "Sporting");
    _codPostalController = TextEditingController(text: "77777");
    _numIntController = TextEditingController(text: "cr9");
    _numExtController = TextEditingController();
    _razonSocialController = TextEditingController(text: "Empresa Prueba");
  }
}
