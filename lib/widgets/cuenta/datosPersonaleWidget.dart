import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DatosPersonalesWidget extends StatefulWidget {
  const DatosPersonalesWidget({Key? key}) : super(key: key);

  @override
  State<DatosPersonalesWidget> createState() => _DatosPersonalesWidgetState();
}

class _DatosPersonalesWidgetState extends State<DatosPersonalesWidget> {
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
  String? fechaNacimiento;

  String? _validarCampo(valor, mensaje) =>
      valor!.trim().isEmpty ? mensaje : null;

  void _actualizarDatosPersonales() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi cuenta - Datos personales"),
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
                    suffixIcon: Icon(Icons.drive_file_rename_outline),
                  ),
                  validator: (value) =>
                      _validarCampo(value, "Introduzca el nombre del usuario"),
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
                      _validarCampo(value, "Introduzca el apellido paterno"),
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
                      _validarCampo(value, "Introduzca el apellido materno"),
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
                      setState(() =>
                          fechaNacimiento = value.toString().substring(0, 10));
                    }),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _telefonoController,
                  decoration: const InputDecoration(
                    labelText: "Teléfono",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) =>
                      _validarCampo(value, "Introduzca un teléfono"),
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: _actualizarDatosPersonales,
                  icon: const Icon(Icons.save),
                  label: const Text("Guardar"),
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
  }
}
