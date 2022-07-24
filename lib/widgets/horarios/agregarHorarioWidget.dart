import 'package:flutter/material.dart';
import 'package:homeshop/models/Dia.dart';
import 'package:homeshop/models/Horario.dart';
import 'package:homeshop/repository/HorarioRepository.dart';
import 'package:intl/intl.dart';
import 'package:date_field/date_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgregarHorarioWidget extends StatefulWidget {
  AgregarHorarioWidget({Key? key}) : super(key: key);

  @override
  State<AgregarHorarioWidget> createState() => _AgregarHorarioWidgetState();
}

class _AgregarHorarioWidgetState extends State<AgregarHorarioWidget> {
  late HorarioRepository _horarioRepository;
  late Horario _horario;
  late Future<SharedPreferences> _prefs;
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

  void _obtenerDias() {}

  void _agregarHorario() {
    List<bool> dias = [
      _lunes,
      _martes,
      _miercoles,
      _jueves,
      _viernes,
      _sabado,
      _domingo
    ];

    bool diaSeleccionado = false;

    for (var dia in dias) {
      if (dia) {
        diaSeleccionado = true;
        break;
      }
    }

    if (!diaSeleccionado) {
      _mostrarSnackbar("Seleccione por lo menos un día", Colors.red[900]);
      return;
    }

    if (formKey.currentState!.validate()) {
      List<String> horaInicioSplit = _horaInicio.toString().split(" ");
      _horario.horaInicioString = horaInicioSplit[1].split(".")[0];
      _horario.duracion = _duracion;
      List<String> horaFinSplit = _horaFin.toString().split(" ");
      _horario.horaFinString = horaFinSplit[1].split(".")[0];
      List<Dia> diasSeleccionados = [];
    }
  }

  void _mostrarSnackbar(String mensaje, color) {
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

  void _mostrarFechasFin() {
    setState(() {
      _horaFin = null;
      _horasFin = <DropdownMenuItem<DateTime>>[];
      List<DateTime> _horasFinAux = [];
      _duracionAux = _duracion!;
      DateTime _hoy = DateTime.now();
      DateTime _fechaLimite =
          DateTime(_hoy.year, _hoy.month, _hoy.day, 23, 59, 0);
      _fechaLimite = _fechaLimite.add(const Duration(minutes: 1));

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
              .add(Duration(hours: _duracionAux * 2))) >
          -1);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agregar Horario"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
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
                  onPressed: _agregarHorario,
                  icon: const Icon(Icons.add),
                  label: const Text("Agregar Horario"),
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
    // TODO: implement initState
    super.initState();
    _horarioRepository = HorarioRepository();
    _horario = Horario();
    _prefs = SharedPreferences.getInstance();
    _prefs
        .then((pref) => _horario.usuario.idUsuario = pref.getInt("idUsuario"));
  }
}
