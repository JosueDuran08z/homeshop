import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

class AgregarUsuariosWidget extends StatefulWidget {
  const AgregarUsuariosWidget({Key? key}) : super(key: key);

  @override
  State<AgregarUsuariosWidget> createState() => _AgregarUsuariosWidgetState();
}

class _AgregarUsuariosWidgetState extends State<AgregarUsuariosWidget> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextStyle textStylePregunta = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
    color: Colors.grey[800],
  );

  late TextEditingController _nombreController;
  late TextEditingController _aPaternoController;
  late TextEditingController _aMaternoController;
  late TextEditingController _telefonoController;
  late TextEditingController _correoController;
  late TextEditingController _contraseniaController;
  late DateTime _diaSeleccionado;

  String? _validarCampo(valor, mensaje) =>
      valor!.trim().isEmpty ? mensaje : null;

  void _agregarUsuario() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Navigator.pop(context);
    }
  }


  String? _roles;
  List<DropdownMenuItem<String>> roles = [
    const DropdownMenuItem<String>(
        value: "Vendedor", child: Text("Vendedor")),
    const DropdownMenuItem<String>(value: "Cliente", child: Text("Cliente")),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agregar usuario"),
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
                      _validarCampo(
                          value, "Introduzca el nombre del usuario"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _aPaternoController,
                  decoration: const InputDecoration(
                    labelText: "Apellido paterno",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.drive_file_rename_outline),
                  ),
                  validator: (value) =>
                      _validarCampo(
                          value, "Introduzca el apellido paterno"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _aMaternoController,
                  decoration: const InputDecoration(
                    labelText: "Apellido materno",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.drive_file_rename_outline),
                  ),
                  validator: (value) =>
                      _validarCampo(
                          value, "Introduzca el apellido materno"),
                ),
                const SizedBox(height: 20),
                TableCalendar(
                  locale: 'es_ES',
                  focusedDay: _diaSeleccionado,
                  firstDay: DateTime.utc(2018, 01, 01),
                  lastDay: DateTime.utc(2023, 01, 01),
                  selectedDayPredicate: (day) =>
                      isSameDay(day, _diaSeleccionado),
                  onDaySelected: (DateTime selectedDate, DateTime focusDay) {
                    setState(() {
                      _diaSeleccionado = selectedDate;
                    });
                  },
                  calendarStyle: const CalendarStyle(
                      todayTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.red
                      )
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField(
                  value: _roles,
                  isExpanded: true,
                  onChanged: (String? value) =>
                      setState(() => _roles = value!),
                  items: roles,
                  decoration: const InputDecoration(
                    labelText: "Roles",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.star_rate),
                  ),
                  validator: (value) =>
                  value == null ? "Seleccione una opción" : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _telefonoController,
                  decoration: const InputDecoration(
                    labelText: "Teléfono",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.location_on_outlined),
                  ),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) =>
                      _validarCampo(value, "Introduzca un teléfono"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _correoController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.email),
                  ),
                  validator: (value) =>
                      _validarCampo(value, "Introduzca un email"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _contraseniaController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Contraseña",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.password),
                  ),
                  validator: (value) =>
                      _validarCampo(value, "Introduzca una contraseña"),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _agregarUsuario,
                  icon: const Icon(Icons.add),
                  label: const Text("Agregar Usuario"),
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
    _aPaternoController = TextEditingController();
    _aMaternoController = TextEditingController();
    _telefonoController = TextEditingController();
    _correoController = TextEditingController();
    _contraseniaController = TextEditingController();
    initializeDateFormatting();
    _diaSeleccionado = DateTime.now();

  }
}