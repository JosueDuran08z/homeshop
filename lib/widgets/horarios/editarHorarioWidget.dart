import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_field/date_field.dart';

class EditarHorarioWidget extends StatefulWidget {
  EditarHorarioWidget({Key? key}) : super(key: key);

  @override
  State<EditarHorarioWidget> createState() => _EditarHorarioWidgetState();
}

class _EditarHorarioWidgetState extends State<EditarHorarioWidget> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextStyle textStylePregunta = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
    color: Colors.grey[800],
  );
  bool _lunes = false,
      _martes = false,
      _miercoles = false,
      _jueves = false,
      _viernes = false,
      _sabado = false,
      _domingo = false;
  int? _duracion;
  int _duracionAux = 0;
  final List<DropdownMenuItem<int>> _duraciones = [
    const DropdownMenuItem<int>(value: 1, child: Text("1 hora")),
    const DropdownMenuItem<int>(value: 2, child: Text("2 horas")),
    const DropdownMenuItem<int>(value: 3, child: Text("3 horas")),
  ];
  DateTime? _horaInicio;
  DateTime? _horaFin;
  List<DropdownMenuItem<DateTime>> _horasFin = <DropdownMenuItem<DateTime>>[];

  void _mostrarFechasFin() {
    setState(() {
      _horaFin = null;
      _horasFin = <DropdownMenuItem<DateTime>>[];
      List<DateTime> _horasFinAux = [];
      _duracionAux = _duracion!;
      DateTime _hoy = DateTime.now();
      DateTime _fechaLimite =
          DateTime(_hoy.year, _hoy.month, _hoy.day, 23, 59, 0);

      do {
        DateTime _horaFin = _horasFinAux.isEmpty
            ? _horaInicio!.add(Duration(hours: _duracionAux))
            : _horasFinAux[_horasFin.length - 1]
                .add(Duration(hours: _duracionAux));
        _horasFinAux.add(_horaFin);
        _horasFin.add(
          DropdownMenuItem<DateTime>(
            value: _horaFin,
            child: Text(DateFormat("hh:mm a").format(_horaFin)),
          ),
        );
      } while (_fechaLimite.compareTo(_horasFinAux[_horasFin.length - 1]
              .add(Duration(hours: _duracionAux))) ==
          1);
    });
  }

  void _seleccionarDuracion(int? value) {
    setState(() => _duracion = value);
    _mostrarFechasFin();
  }

  void _seleccionarHoraInicio(DateTime value) {
    if (value != _horaInicio) {
      setState(() => _horaInicio = value);
      if (_duracion != null) _mostrarFechasFin();
    }
  }

  String? _validarCampo(valor, mensaje) =>
      valor!.trim().isEmpty ? mensaje : null;

  void _editarHorario() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Horario"),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(children: [
                Row(
                  children: [
                    Text(
                      "Dia(s)",
                      style: textStylePregunta,
                    ),
                  ],
                ),
                CheckboxListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text("Lunes"),
                  value: _lunes,
                  onChanged: (bool? value) => setState(() => _lunes = value!),
                ),
                CheckboxListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text("Martes"),
                  value: _martes,
                  onChanged: (bool? value) => setState(() => _martes = value!),
                ),
                CheckboxListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text("Miércoles"),
                  value: _miercoles,
                  onChanged: (bool? value) =>
                      setState(() => _miercoles = value!),
                ),
                CheckboxListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text("Jueves"),
                  value: _jueves,
                  onChanged: (bool? value) => setState(() => _jueves = value!),
                ),
                CheckboxListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text("Viernes"),
                  value: _viernes,
                  onChanged: (bool? value) => setState(() => _viernes = value!),
                ),
                CheckboxListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text("Sábado"),
                  value: _sabado,
                  onChanged: (bool? value) => setState(() => _sabado = value!),
                ),
                CheckboxListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text("Domingo"),
                  value: _domingo,
                  onChanged: (bool? value) => setState(() => _domingo = value!),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "Hora",
                      style: textStylePregunta,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                DateTimeFormField(
                  initialValue: DateTime.parse("2022-07-05 08:00:00"),
                  decoration: const InputDecoration(
                      labelText: "Inicio",
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.timer_outlined)),
                  mode: DateTimeFieldPickerMode.time,
                  validator: (date) =>
                      date == null ? "Seleccione una fecha" : null,
                  onDateSelected: _seleccionarHoraInicio,
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField(
                  value: _duracion,
                  isExpanded: true,
                  onChanged: _seleccionarDuracion,
                  items: _horaInicio != null ? _duraciones : null,
                  decoration: const InputDecoration(
                    labelText: "Duración",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.timelapse),
                  ),
                  validator: (value) =>
                      value == null ? "Seleccione una opción" : null,
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField(
                  value: _horaFin,
                  isExpanded: true,
                  onChanged: (DateTime? value) =>
                      setState(() => _horaFin = value!),
                  items: _horasFin,
                  decoration: const InputDecoration(
                    labelText: "Fin",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.timer_off_outlined),
                  ),
                  validator: (value) =>
                      value == null ? "Seleccione una opción" : null,
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: _editarHorario,
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
              ]),
            )),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lunes = true;
    _martes = true;
    _miercoles = true;
    _horaInicio = DateTime.parse("2022-07-05 08:00:00");
    _duracion = 1;
    _mostrarFechasFin();
    _horaFin = DateTime.parse("2022-07-05 10:00:00");
  }
}
