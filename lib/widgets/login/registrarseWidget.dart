import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/services.dart';
import 'package:homeshop/widgets/login/loginWidget.dart';
import 'package:intl/intl.dart';

class RegistrarseWidget extends StatefulWidget {
  RegistrarseWidget({Key? key}) : super(key: key);

  @override
  State<RegistrarseWidget> createState() => _RegistrarseWidgetState();
}

class _RegistrarseWidgetState extends State<RegistrarseWidget> {
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
      _numExtController;
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
    /* final route = MaterialPageRoute(builder: (BuildContext context) => Login());
    Navigator.push(context, route); */
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final route =
          MaterialPageRoute(builder: (BuildContext context) => LoginWidget());
      Navigator.push(context, route);
    }
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
                                controller: _calleController,
                                decoration: const InputDecoration(
                                  labelText: "Razón Social",
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.map),
                                ),
                                validator: (value) =>
                                    _validarCampo(value, "Introduzca la calle"),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _calleController,
                                decoration: const InputDecoration(
                                  labelText: "RFC",
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.map),
                                ),
                                validator: (value) =>
                                    _validarCampo(value, "Introduzca la calle"),
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
    _nombreController = TextEditingController();
    _apePController = TextEditingController();
    _apeMController = TextEditingController();
    _emailController = TextEditingController();
    _contraseniaController = TextEditingController();
    _telefonoController = TextEditingController();
    _calleController = TextEditingController();
    _coloniaController = TextEditingController();
    _codPostalController = TextEditingController();
    _numIntController = TextEditingController();
    _numExtController = TextEditingController();
  }
}
