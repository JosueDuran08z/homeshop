import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:homeshop/models/Inmueble.dart';
import 'package:homeshop/repository/InmuebleRepository.dart';
import 'package:homeshop/widgets/inmuebles/inmuebleWidget.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class InmueblesWidget extends StatefulWidget {
  InmueblesWidget({Key? key}) : super(key: key);

  @override
  State<InmueblesWidget> createState() => _InmueblesWidgetState();
}

class _InmueblesWidgetState extends State<InmueblesWidget> {
  late Future<SharedPreferences> _prefs;
  late InmuebleRepository _inmuebleRepository;
  late List<Inmueble> _inmuebles;
  late bool _sinInmuebles;

  void _obtenerPublicaciones() async {
    try {
      int idUsuario = await _prefs.then((value) => value.getInt("idUsuario")!);
      Future<http.Response?> response =
          _inmuebleRepository.obtenerPublicaciones(idUsuario);

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

  void _mostrarInmueble(int idInmueble) {
    final route = MaterialPageRoute(
        builder: (BuildContext context) => InmuebleWidget(idInmueble));
    Navigator.push(context, route);
  }

  void _abrirWhatsApp(int telefono, String direccion) async {
    bool whatsapp = await FlutterLaunch.hasApp(name: "whatsapp");

    if (whatsapp) {
      await FlutterLaunch.launchWhatsapp(
          phone: telefono.toString(),
          message: "Hola, me interesa el inmueble ubicado en $direccion.");
    } else {
      _mostrarSnackbar(
          "¡Ocurrió un error inesperado! Vuelve a intentarlo más tarde.",
          Colors.red[900]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_sinInmuebles)
          Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
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
          ),
        _inmuebles.isEmpty && !_sinInmuebles
            ? Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
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
                ),
              )
            : Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: _inmuebles.length,
                  itemBuilder: (BuildContext context, int i) {
                    return GestureDetector(
                      onTap: () => _mostrarInmueble(_inmuebles[i].idInmueble!),
                      child: Card(
                        child: Column(
                          children: [
                            ImageSlideshow(
                              children: [
                                Image.memory(_inmuebles[i].imagen1Decodificada!,
                                    fit: BoxFit.cover),
                                if (_inmuebles[i].imagen2Decodificada != null)
                                  Image.memory(
                                      _inmuebles[i].imagen2Decodificada!,
                                      fit: BoxFit.cover),
                                if (_inmuebles[i].imagen3Decodificada != null)
                                  Image.memory(
                                      _inmuebles[i].imagen3Decodificada!,
                                      fit: BoxFit.cover),
                                if (_inmuebles[i].imagen4Decodificada != null)
                                  Image.memory(
                                      _inmuebles[i].imagen4Decodificada!,
                                      fit: BoxFit.cover),
                                if (_inmuebles[i].imagen5Decodificada != null)
                                  Image.memory(
                                      _inmuebles[i].imagen5Decodificada!,
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
                                            color: Colors.red,
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
                                                  _inmuebles[i].estatus ==
                                                      "Renta"
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
                                          style: TextStyle(
                                              color: Colors.grey[800]),
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
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () => _abrirWhatsApp(
                                            _inmuebles[i].usuario.telefono!,
                                            "${_inmuebles[i].calle} ${_inmuebles[i].numInterior}${_inmuebles[i].numExterior ?? ""}, ${_inmuebles[i].colonia}, C.P. ${_inmuebles[i].cp}"),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.green,
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            top: 10,
                                            right: 10,
                                            bottom: 10,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.whatsapp,
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
    _obtenerPublicaciones();
  }
}
