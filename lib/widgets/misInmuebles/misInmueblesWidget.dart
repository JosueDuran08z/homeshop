import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:homeshop/models/Inmueble.dart';
import 'package:homeshop/repository/InmuebleRepository.dart';
import 'package:homeshop/widgets/misInmuebles/agregarInmuebleWidget.dart';
import 'package:homeshop/widgets/misInmuebles/editarInmuebleWidget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MisInmueblesWidget extends StatefulWidget {
  MisInmueblesWidget({Key? key}) : super(key: key);

  @override
  State<MisInmueblesWidget> createState() => _MisInmueblesWidgetState();
}

class _MisInmueblesWidgetState extends State<MisInmueblesWidget> {
  late InmuebleRepository _inmuebleRepository;
  late List<Inmueble> _inmuebles;

  void _obtenerInmuebles() {
    try {
      Future<http.Response?> response = _inmuebleRepository.obtenerTodos();

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
            setState(() => _inmuebles.add(inmueble));
          });
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
        builder: (BuildContext context) =>
            EditarInmuebleWidget(idInmueble + 1));
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

  void _mostrarModal(BuildContext context, int idInmueble, bool eliminar) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            "¿Estás seguro que deseas ${eliminar ? "eliminar" : "activar"} este inmueble?",
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
                  _eliminarActivarInmueble(context, idInmueble, eliminar),
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

  void _eliminarActivarInmueble(context, int idInmueble, bool eliminar) {
    try {
      Future<http.Response?> response = eliminar
          ? _inmuebleRepository.eliminar(idInmueble)
          : _inmuebleRepository.activar(idInmueble);

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
        Expanded(
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
                        right: 10,
                        bottom: 20,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    color: Color.fromARGB(255, 229, 57, 53),
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
                                  style: TextStyle(color: Colors.red[600]),
                                ),
                              ),
                              if (_inmuebles[i].estatus == "Venta" ||
                                  _inmuebles[i].estatus == "Renta")
                                Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () => _editarInmueble(i + 1),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.blue[800],
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            top: 5,
                                            right: 10,
                                            bottom: 5,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          )),
                                      child: const Icon(
                                        Icons.edit,
                                        size: 18,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () =>
                                          _mostrarModal(context, i + 1, true),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.red[600],
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            top: 5,
                                            right: 10,
                                            bottom: 5,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          )),
                                      child: const Icon(
                                        Icons.delete,
                                        size: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              if (_inmuebles[i].estatus == "Eliminado")
                                Row(children: [
                                  ElevatedButton.icon(
                                    icon: const Icon(Icons.check_circle),
                                    label: const Text("Activar"),
                                    onPressed: () =>
                                        _mostrarModal(context, i + 1, false),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.green[700],
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
                                  ),
                                ]),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "${_inmuebles[i].calle} ${_inmuebles[i].numInterior} ${_inmuebles[i].numExterior != null ? _inmuebles[i].numExterior : ""} ${_inmuebles[i].colonia} C.P. ${_inmuebles[i].cp}",
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          )
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
    // TODO: implement initState
    super.initState();
    _inmuebleRepository = InmuebleRepository();
    _inmuebles = <Inmueble>[];
    _obtenerInmuebles();
  }
}
