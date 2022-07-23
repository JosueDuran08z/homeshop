import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:homeshop/models/Inmueble.dart';
import 'package:homeshop/repository/InmuebleRepository.dart';
import 'package:homeshop/widgets/misInmuebles/agregarInmuebleWidget.dart';
import 'package:homeshop/widgets/misInmuebles/editarInmuebleWidget.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MisInmueblesWidget extends StatefulWidget {
  MisInmueblesWidget({Key? key}) : super(key: key);

  @override
  State<MisInmueblesWidget> createState() => _MisInmueblesWidgetState();
}

class _MisInmueblesWidgetState extends State<MisInmueblesWidget> {
  late Future<SharedPreferences> _prefs;
  late InmuebleRepository _inmuebleRepository;
  late List<Inmueble> _inmuebles;
  late bool _sinInmuebles;

  void _obtenerInmuebles() async {
    try {
      int idUsuario = await _prefs.then((value) => value.getInt("idUsuario")!);
      Future<http.Response?> response =
          _inmuebleRepository.obtenerTodosPorUsuarioId(idUsuario);

      response.then((http.Response? response) {
        var responseData = jsonDecode(response!.body);
        if (response.statusCode == 200) {
          const Base64Decoder base64Decoder = Base64Decoder();

          responseData.forEach((inmuebleData) {
            Inmueble inmueble = Inmueble();
            inmueble.setInmueble(inmuebleData);

            inmueble.imagen1Decodificada =
                const Base64Decoder().convert(inmueble.imagen1!);
            if (inmueble.imagen2 != null) {
              inmueble.imagen2Decodificada =
                  base64Decoder.convert(inmueble.imagen2!);
            }
            if (inmueble.imagen3 != null) {
              inmueble.imagen3Decodificada =
                  base64Decoder.convert(inmueble.imagen3!);
            }
            if (inmueble.imagen4 != null) {
              inmueble.imagen4Decodificada =
                  base64Decoder.convert(inmueble.imagen4!);
            }
            if (inmueble.imagen5 != null) {
              inmueble.imagen5Decodificada =
                  base64Decoder.convert(inmueble.imagen5!);
            }
            _inmuebles.add(inmueble);
          });

          setState(
              () => _inmuebles.isEmpty ? _sinInmuebles = true : _inmuebles);
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

  void _agregarInmueble() {
    final route = MaterialPageRoute(
        builder: (BuildContext context) => AgregarInmuebleWidget());
    Navigator.push(context, route);
  }

  void _editarInmueble(idInmueble) {
    final route = MaterialPageRoute(
        builder: (BuildContext context) => EditarInmuebleWidget(idInmueble));
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

  void _mostrarModal(BuildContext context, int idInmueble,
      {bool? eliminar, bool? activar, bool? vender, bool? rentar}) {
    String operacion = "";

    if (eliminar != null)
      operacion = "eliminar";
    else if (activar != null)
      operacion = "activar";
    else if (vender != null)
      operacion = "vender";
    else
      operacion = "rentar";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            "¿Está seguro que desea ${operacion == "activar" ? "volver a publicar" : operacion} este inmueble?",
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
                  _cambiarEstatusInmueble(context, idInmueble, operacion),
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

  void _cambiarEstatusInmueble(context, int idInmueble, String operacion) {
    try {
      Future<http.Response?> response =
          _inmuebleRepository.cambiarEstatus(idInmueble, operacion);

      response.then((http.Response? response) {
        var responseData = jsonDecode(response!.body);
        if (response.statusCode == 200) {
          Navigator.pop(context);
          _mostrarSnackbar(responseData["mensaje"], Colors.green[700]);
          setState(() => _inmuebles = []);
          _obtenerInmuebles();
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
                "Mis Inmuebles",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[600],
                ),
              ),
              ElevatedButton(
                onPressed: _agregarInmueble,
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
        if (_sinInmuebles)
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
        _inmuebles.isEmpty && !_sinInmuebles
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
                  itemCount: _inmuebles.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Card(
                      child: Column(
                        children: [
                          ImageSlideshow(
                            children: [
                              Image.memory(_inmuebles[i].imagen1Decodificada!,
                                  fit: BoxFit.cover),
                              if (_inmuebles[i].imagen2Decodificada != null)
                                Image.memory(_inmuebles[i].imagen2Decodificada!,
                                    fit: BoxFit.cover),
                              if (_inmuebles[i].imagen3Decodificada != null)
                                Image.memory(_inmuebles[i].imagen3Decodificada!,
                                    fit: BoxFit.cover),
                              if (_inmuebles[i].imagen4Decodificada != null)
                                Image.memory(_inmuebles[i].imagen4Decodificada!,
                                    fit: BoxFit.cover),
                              if (_inmuebles[i].imagen5Decodificada != null)
                                Image.memory(_inmuebles[i].imagen5Decodificada!,
                                    fit: BoxFit.cover),
                            ],
                          ),
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
                                      "\$ ${_inmuebles[i].precio}",
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
                                          color: Colors.red[600]!,
                                        ),
                                      ),
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        top: 5,
                                        right: 10,
                                        bottom: 5,
                                      ),
                                      child: Text(
                                        _inmuebles[i].estatus == "Venta" ||
                                                _inmuebles[i].estatus == "Renta"
                                            ? "En ${_inmuebles[i].estatus}"
                                            : _inmuebles[i].estatus!,
                                        style:
                                            TextStyle(color: Colors.red[600]),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                        border: Border.all(
                                          color: Colors.grey[800]!,
                                        ),
                                      ),
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        top: 5,
                                        right: 10,
                                        bottom: 5,
                                      ),
                                      child: Text(
                                        _inmuebles[i].casa.idCasa != null
                                            ? "Casa"
                                            : _inmuebles[i]
                                                        .departamento
                                                        .idDepartamento !=
                                                    null
                                                ? "Departamento"
                                                : _inmuebles[i]
                                                            .edificio
                                                            .idEdificio !=
                                                        null
                                                    ? "Edificio"
                                                    : _inmuebles[i]
                                                                .terreno
                                                                .idTerreno !=
                                                            null
                                                        ? "Terreno"
                                                        : "",
                                        style:
                                            TextStyle(color: Colors.grey[800]),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "${_inmuebles[i].calle} ${_inmuebles[i].numInterior}${_inmuebles[i].numExterior ?? ""}, ${_inmuebles[i].colonia}, C.P. ${_inmuebles[i].cp}",
                                  style: const TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                if (_inmuebles[i].estatus == "Venta" ||
                                    _inmuebles[i].estatus == "Renta")
                                  Column(
                                    children: [
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton.icon(
                                            label: const Text("Editar"),
                                            onPressed: () =>
                                                _editarInmueble(i + 1),
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.blue[800],
                                                padding:
                                                    const EdgeInsets.all(15),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
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
                                                context, i + 1,
                                                eliminar: true),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.red[600],
                                              padding: const EdgeInsets.all(15),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                            icon: const Icon(
                                              Icons.delete,
                                              size: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    if (_inmuebles[i].estatus == "Eliminado" ||
                                        _inmuebles[i].estatus == "Vendido" ||
                                        _inmuebles[i].estatus == "Rentado")
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton.icon(
                                            icon: const Icon(
                                              Icons.refresh,
                                              size: 18,
                                            ),
                                            label:
                                                const Text("Volver a publicar"),
                                            onPressed: () => _mostrarModal(
                                                context, i + 1,
                                                activar: true),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.green[700],
                                              padding: const EdgeInsets.all(15),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (_inmuebles[i].estatus != "Eliminado" &&
                                        _inmuebles[i].estatus != "Vendido" &&
                                        _inmuebles[i].estatus != "Rentado")
                                      ElevatedButton.icon(
                                        label: Text(
                                            _inmuebles[i].estatus == "Venta"
                                                ? "Vender"
                                                : "Rentar"),
                                        onPressed: () =>
                                            _inmuebles[i].estatus == "Venta"
                                                ? _mostrarModal(context, i + 1,
                                                    vender: true)
                                                : _mostrarModal(context, i + 1,
                                                    rentar: true),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.green[700],
                                          padding: const EdgeInsets.all(15),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        icon: const Icon(
                                          Icons.real_estate_agent_outlined,
                                          size: 18,
                                        ),
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
    _inmuebleRepository = InmuebleRepository();
    _inmuebles = <Inmueble>[];
    _sinInmuebles = false;
    _obtenerInmuebles();
  }
}
