import 'package:flutter/material.dart';
import 'package:homeshop/models/Horario.dart';
import 'package:homeshop/repository/HorarioRepository.dart';
import 'package:homeshop/widgets/horarios/agregarHorarioWidget.dart';
import 'package:homeshop/widgets/horarios/editarHorarioWidget.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MisHorariosWidget extends StatefulWidget {
  MisHorariosWidget({Key? key}) : super(key: key);

  @override
  State<MisHorariosWidget> createState() => _MisHorariosWidgetState();
}

class _MisHorariosWidgetState extends State<MisHorariosWidget> {
  late Future<SharedPreferences> _prefs;
  late HorarioRepository _horarioRepository;
  late List<Horario> _horarios;
  late bool _sinHorarios;

  void _obtenerHorarios() async {
    try {
      int idUsuario = await _prefs.then((value) => value.getInt("idUsuario")!);
      Future<http.Response?> response =
          _horarioRepository.obtenerTodosPorUsuarioId(idUsuario);

      response.then((http.Response? response) {
        var responseData = jsonDecode(response!.body);
        if (response.statusCode == 200) {
          responseData.forEach((horarioData) {
            Horario horario = Horario();
            horario.setHorario(horarioData);
            _horarios.add(horario);
          });

          setState(() => _horarios.isEmpty ? _sinHorarios = true : _horarios);
        } else {
          _mostrarSnackbar(responseData["mensaje"], Colors.red[900]);
        }
      });
    } catch (e) {
      _mostrarSnackbar(
          "¡Ocurrió un error inesperado! Vuelve a intentarlo más tarde.",
          Colors.red[900]);
    }
  }

  void _agregarHorario() {
    final route = MaterialPageRoute(
        builder: (BuildContext context) => AgregarHorarioWidget());
    Navigator.push(context, route);
  }

  void _editarHorario(idHorario) {
    final route = MaterialPageRoute(
        builder: (BuildContext context) => EditarHorarioWidget(idHorario));
    Navigator.push(context, route);
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

  void _mostrarModal(BuildContext context, int idHorario, bool eliminar) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            "¿Está seguro que desea ${eliminar ? "eliminar" : "activar"} este horario?",
            textAlign: TextAlign.justify,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Cancelar",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () =>
                  _cambiarEstatusHorario(context, idHorario, eliminar),
              child: Text(
                "Aceptar",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _cambiarEstatusHorario(context, int idHorario, bool eliminar) {
    try {
      Future<http.Response?> response =
          _horarioRepository.cambiarEstatus(idHorario, eliminar);

      response.then((http.Response? response) {
        var responseData = jsonDecode(response!.body);
        if (response.statusCode == 200) {
          Navigator.pop(context);
          _mostrarSnackbar(responseData["mensaje"], Colors.green[700]);
          setState(() => _horarios = []);
          _obtenerHorarios();
        } else {
          _mostrarSnackbar(responseData["mensaje"], Colors.red[900]);
        }
      });
    } catch (e) {
      _mostrarSnackbar(
          "¡Ocurrió un error inesperado! Vuelve a intentarlo más tarde.",
          Colors.red[900]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Mis Horarios",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[600],
                ),
              ),
              ElevatedButton(
                onPressed: _agregarHorario,
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[800],
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 5,
                    right: 10,
                    bottom: 5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Icon(
                  Icons.add,
                  size: 18,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        if (_sinHorarios)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, size: 70, color: Colors.grey[600]),
              const SizedBox(height: 10),
              Text(
                "No hay inmuebles por mostrar",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.grey[800]),
              ),
            ],
          ),
        _horarios.isEmpty && !_sinHorarios
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 10),
                  Text(
                    "Cargando inmuebles...",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.grey[800]),
                  )
                ],
              )
            : Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  itemCount: _horarios.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              top: 20,
                              right: 20,
                              bottom: 20,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${DateFormat("hh:mm a").format(_horarios[i].horaInicio!)} - ${DateFormat("hh:mm a").format(_horarios[i].horaFin!)}",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                        border: Border.all(
                                          color: _horarios[i].estatus!
                                              ? Colors.green[700]!
                                              : Colors.red[600]!,
                                        ),
                                      ),
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        top: 5,
                                        right: 10,
                                        bottom: 5,
                                      ),
                                      child: Text(
                                        _horarios[i].estatus!
                                            ? "Activo"
                                            : "Eliminado",
                                        style: TextStyle(
                                            color: _horarios[i].estatus!
                                                ? Colors.green[700]
                                                : Colors.red[600]),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      _horarios[i].diasString!,
                                      style: const TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    _horarios[i].estatus!
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton.icon(
                                                label: const Text("Editar"),
                                                onPressed: () => _editarHorario(
                                                    _horarios[i].idHorario!),
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.blue[800],
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    )),
                                                icon: const Icon(
                                                  Icons.edit,
                                                  size: 18,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              ElevatedButton.icon(
                                                label: const Text("Eliminar"),
                                                onPressed: () => _mostrarModal(
                                                    context,
                                                    _horarios[i].idHorario!,
                                                    true),
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.red[600],
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                ),
                                                icon: const Icon(
                                                  Icons.delete,
                                                  size: 18,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton.icon(
                                                icon: const Icon(
                                                  Icons.check_circle_sharp,
                                                  size: 18,
                                                ),
                                                label: const Text("Activar"),
                                                onPressed: () => _mostrarModal(
                                                    context,
                                                    _horarios[i].idHorario!,
                                                    false),
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.green[700],
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _prefs = SharedPreferences.getInstance();
    _horarioRepository = HorarioRepository();
    _horarios = <Horario>[];
    _sinHorarios = false;
    _obtenerHorarios();
  }
}
