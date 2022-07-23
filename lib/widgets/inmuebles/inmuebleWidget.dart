import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:homeshop/models/Inmueble.dart';
import 'package:homeshop/repository/InmuebleRepository.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InmuebleWidget extends StatefulWidget {
  InmuebleWidget(this.idInmueble, {Key? key}) : super(key: key);
  int idInmueble;

  @override
  State<InmuebleWidget> createState() => _InmuebleWidgetState(idInmueble);
}

class _InmuebleWidgetState extends State<InmuebleWidget> {
  _InmuebleWidgetState(this.idInmueble);
  int idInmueble;
  late InmuebleRepository _inmuebleRepository;
  late Inmueble _inmueble;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? _diaCita;
  List<DropdownMenuItem<String>> _diasDisponiblesCita = [
    const DropdownMenuItem<String>(value: "Lunes", child: Text("Lunes")),
    const DropdownMenuItem<String>(value: "Martes", child: Text("Martes")),
    const DropdownMenuItem<String>(
        value: "Miércoles", child: Text("Miércoles")),
    const DropdownMenuItem<String>(value: "Jueves", child: Text("Jueves")),
    const DropdownMenuItem<String>(value: "Viernes", child: Text("Viernes")),
  ];

  DateTime? _horaCita;
  List<DropdownMenuItem<DateTime>> _horasDisponiblesCita = [
    DropdownMenuItem<DateTime>(
        value: DateTime.parse("2022-07-05 08:00:00"),
        child: Text(DateFormat("hh:mm a")
            .format(DateTime.parse("2022-07-05 08:00:00")))),
    DropdownMenuItem<DateTime>(
        value: DateTime.parse("2022-07-05 09:00:00"),
        child: Text(DateFormat("hh:mm a")
            .format(DateTime.parse("2022-07-05 09:00:00")))),
    DropdownMenuItem<DateTime>(
        value: DateTime.parse("2022-07-05 10:00:00"),
        child: Text(DateFormat("hh:mm a")
            .format(DateTime.parse("2022-07-05 10:00:00")))),
    DropdownMenuItem<DateTime>(
        value: DateTime.parse("2022-07-05 11:00:00"),
        child: Text(DateFormat("hh:mm a")
            .format(DateTime.parse("2022-07-05 11:00:00")))),
    DropdownMenuItem<DateTime>(
        value: DateTime.parse("2022-07-05 12:00:00"),
        child: Text(DateFormat("hh:mm a")
            .format(DateTime.parse("2022-07-05 12:00:00")))),
    DropdownMenuItem<DateTime>(
        value: DateTime.parse("2022-07-05 13:00:00"),
        child: Text(DateFormat("hh:mm a")
            .format(DateTime.parse("2022-07-05 13:00:00")))),
  ];

  TextStyle textStyleTitulo = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.red[600],
  );
  TextStyle textStyleParrafo = TextStyle(
    fontSize: 15,
    color: Colors.grey[700],
  );

  void _obtenerInmueble() {
    try {
      Future<http.Response?> response =
          _inmuebleRepository.obtenerPorId(idInmueble);

      response.then((http.Response? response) {
        var responseData = jsonDecode(response!.body);
        if (response.statusCode == 200) {
          const Base64Decoder base64Decoder = Base64Decoder();
          _inmueble.setInmueble(responseData);
          _inmueble.imagen1Decodificada =
              const Base64Decoder().convert(_inmueble.imagen1!);
          if (_inmueble.imagen2 != null) {
            _inmueble.imagen2Decodificada =
                base64Decoder.convert(_inmueble.imagen2!);
          }
          if (_inmueble.imagen3 != null) {
            _inmueble.imagen3Decodificada =
                base64Decoder.convert(_inmueble.imagen3!);
          }
          if (_inmueble.imagen4 != null) {
            _inmueble.imagen4Decodificada =
                base64Decoder.convert(_inmueble.imagen4!);
          }
          if (_inmueble.imagen5 != null) {
            _inmueble.imagen5Decodificada =
                base64Decoder.convert(_inmueble.imagen5!);
          }

          setState(() => _inmueble);
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

  void _abrirWhatsApp() async {
    bool whatsapp = await FlutterLaunch.hasApp(name: "whatsapp");

    if (whatsapp) {
      await FlutterLaunch.launchWhatsapp(
          phone: "4773002254", message: "Hola, me interesa este inmueble");
    } else {
      _mostrarSnackbar(
          "¡Ocurrió un error inesperado! Vuelve a intentarlo más tarde.",
          Colors.red[900]);
    }
  }

  void _agendarCita() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      SnackBar snackbar = SnackBar(
        content: const Text(
          "!Cita agendada correctamente!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue[600],
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      setState(() {
        _diasDisponiblesCita = [];
        _horasDisponiblesCita = [];
      });
    }
  }

  Row ElementoDetalle(texto, icono, valor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icono,
          color: Colors.red[900],
          size: 25,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              texto,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
              ),
            ),
            Text(
              valor.toString(),
              style: TextStyle(
                fontSize: 15,
                color: Colors.red[900],
              ),
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(_inmueble.idInmueble == null
              ? ""
              : "${_inmueble.calle} ${_inmueble.numInterior}${_inmueble.numExterior ?? ""}, ${_inmueble.colonia}, C.P. ${_inmueble.cp}")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: _inmueble.idInmueble == null
              ? Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const CircularProgressIndicator(),
                      const SizedBox(height: 10),
                      Text(
                        "Cargando inmueble...",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.grey[800]),
                      )
                    ],
                  ),
                )
              : Column(
                  children: [
                    ImageSlideshow(
                      children: [
                        Image.memory(_inmueble.imagen1Decodificada!,
                            fit: BoxFit.cover),
                        if (_inmueble.imagen2Decodificada != null)
                          Image.memory(_inmueble.imagen2Decodificada!,
                              fit: BoxFit.cover),
                        if (_inmueble.imagen3Decodificada != null)
                          Image.memory(_inmueble.imagen3Decodificada!,
                              fit: BoxFit.cover),
                        if (_inmueble.imagen4Decodificada != null)
                          Image.memory(_inmueble.imagen4Decodificada!,
                              fit: BoxFit.cover),
                        if (_inmueble.imagen5Decodificada != null)
                          Image.memory(_inmueble.imagen5Decodificada!,
                              fit: BoxFit.cover),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                                _inmueble.estatus == "Venta" ||
                                        _inmueble.estatus == "Renta"
                                    ? "En ${_inmueble.estatus}"
                                    : _inmueble.estatus!,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.red[600],
                                ),
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
                                _inmueble.casa.idCasa != null
                                    ? "Casa"
                                    : _inmueble.departamento.idDepartamento !=
                                            null
                                        ? "Departamento"
                                        : _inmueble.edificio.idEdificio != null
                                            ? "Edificio"
                                            : _inmueble.terreno.idTerreno !=
                                                    null
                                                ? "Terreno"
                                                : "",
                                style: TextStyle(color: Colors.grey[800]),
                              ),
                            ),
                            Text(
                              "\$ ${_inmueble.precio}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Text(
                              "Dirección",
                              style: textStyleTitulo,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              "${_inmueble.calle} ${_inmueble.numInterior}${_inmueble.numExterior ?? ""}, ${_inmueble.colonia}, C.P. ${_inmueble.cp}",
                              style: textStyleParrafo,
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Text(
                              "Descripción",
                              style: textStyleTitulo,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              _inmueble.descripcion!,
                              style: textStyleParrafo,
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Text(
                              "Detalles",
                              style: textStyleTitulo,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ElementoDetalle("Ancho",
                                    Icons.arrow_back_outlined, "10 metros"),
                                const SizedBox(height: 10),
                                ElementoDetalle("Agua", Icons.water_drop, "Sí"),
                                if (_inmueble.terreno.idTerreno == null)
                                  const SizedBox(height: 10),
                                if (_inmueble.casa.idCasa != null)
                                  ElementoDetalle("Cochera", Icons.garage,
                                      _inmueble.casa.cochera! ? "Sí" : "No"),
                                if (_inmueble.departamento.idDepartamento !=
                                    null)
                                  ElementoDetalle(
                                      "Estacionamiento",
                                      Icons.garage,
                                      _inmueble.departamento.estacionamiento!
                                          ? "Sí"
                                          : "No"),
                                if (_inmueble.edificio.idEdificio != null)
                                  ElementoDetalle(
                                      "Estacionamiento",
                                      Icons.garage,
                                      _inmueble.edificio.estacionamiento!
                                          ? "Sí"
                                          : "No"),
                                if (_inmueble.terreno.idTerreno == null)
                                  const SizedBox(height: 10),
                                if (_inmueble.casa.idCasa != null)
                                  ElementoDetalle("Internet", Icons.wifi,
                                      _inmueble.casa.internet! ? "Sí" : "No"),
                                if (_inmueble.departamento.idDepartamento !=
                                    null)
                                  ElementoDetalle(
                                      "Internet",
                                      Icons.wifi,
                                      _inmueble.departamento.internet!
                                          ? "Sí"
                                          : "No"),
                                if (_inmueble.edificio.idEdificio != null)
                                  ElementoDetalle(
                                      "Internet",
                                      Icons.wifi,
                                      _inmueble.edificio.internet!
                                          ? "Sí"
                                          : "No"),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ElementoDetalle(
                                    "Largo", Icons.arrow_upward, "20 metros"),
                                const SizedBox(height: 10),
                                ElementoDetalle(
                                    "Luz", Icons.lightbulb_circle_sharp, "Sí"),
                                if (_inmueble.terreno.idTerreno == null)
                                  const SizedBox(height: 10),
                                if (_inmueble.casa.idCasa != null)
                                  ElementoDetalle("Pisos", Icons.stairs,
                                      _inmueble.casa.pisos),
                                if (_inmueble.departamento.idDepartamento !=
                                    null)
                                  ElementoDetalle("Pisos", Icons.stairs,
                                      _inmueble.departamento.pisos),
                                if (_inmueble.edificio.idEdificio != null)
                                  ElementoDetalle("Pisos", Icons.stairs,
                                      _inmueble.edificio.pisos),
                                if (_inmueble.terreno.idTerreno == null)
                                  const SizedBox(height: 10),
                                if (_inmueble.casa.idCasa != null)
                                  ElementoDetalle("Habitaciones", Icons.bed,
                                      _inmueble.casa.habitaciones),
                                if (_inmueble.departamento.idDepartamento !=
                                    null)
                                  ElementoDetalle("Habitaciones", Icons.bed,
                                      _inmueble.departamento.habitaciones),
                                if (_inmueble.edificio.idEdificio != null)
                                  ElementoDetalle("Habitaciones", Icons.bed,
                                      _inmueble.edificio.habitaciones),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ElementoDetalle(
                                    "Dimensión", Icons.house, "210 m²"),
                                const SizedBox(height: 10),
                                ElementoDetalle("Baños", Icons.bathtub, 2),
                                if (_inmueble.terreno.idTerreno == null)
                                  const SizedBox(height: 10),
                                if (_inmueble.casa.idCasa != null)
                                  ElementoDetalle(
                                      "Edad",
                                      Icons.hourglass_bottom,
                                      "${_inmueble.casa.edad} años"),
                                if (_inmueble.departamento.idDepartamento !=
                                    null)
                                  ElementoDetalle(
                                      "Edad",
                                      Icons.hourglass_bottom,
                                      "${_inmueble.departamento.edad} años"),
                                if (_inmueble.edificio.idEdificio != null)
                                  ElementoDetalle(
                                      "Edad",
                                      Icons.hourglass_bottom,
                                      "${_inmueble.edificio.edad} años"),
                                if (_inmueble.terreno.idTerreno == null)
                                  const SizedBox(height: 10),
                                if (_inmueble.casa.idCasa != null)
                                  ElementoDetalle("Estado", Icons.star_rate,
                                      _inmueble.casa.estadoInstalaciones),
                                if (_inmueble.departamento.idDepartamento !=
                                    null)
                                  ElementoDetalle(
                                      "Estado",
                                      Icons.star_rate,
                                      _inmueble
                                          .departamento.estadoInstalaciones),
                                if (_inmueble.edificio.idEdificio != null)
                                  ElementoDetalle("Estado", Icons.star_rate,
                                      _inmueble.edificio.estadoInstalaciones),
                              ],
                            ),
                          ],
                        ),
                        if (_inmueble.terreno.idTerreno != null)
                          Column(
                            children: [
                              const SizedBox(height: 10),
                              ElementoDetalle(
                                  "En construcción",
                                  Icons.build_circle,
                                  _inmueble.terreno.enConstruccion!
                                      ? "Sí"
                                      : "No"),
                            ],
                          ),
                        const SizedBox(height: 40),
                        Row(
                          children: [
                            Text(
                              "Agenda una Cita con el Vendedor",
                              style: textStyleTitulo,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Form(
                            key: formKey,
                            child: Column(
                              children: [
                                DropdownButtonFormField(
                                  value: _diaCita,
                                  isExpanded: true,
                                  onChanged: (String? value) =>
                                      setState(() => _diaCita = value!),
                                  items: _diasDisponiblesCita,
                                  decoration: const InputDecoration(
                                    labelText: "Día",
                                    border: OutlineInputBorder(),
                                    suffixIcon: Icon(Icons.calendar_month),
                                  ),
                                  validator: (value) => value == null
                                      ? "Seleccione un día"
                                      : null,
                                ),
                                const SizedBox(height: 20),
                                DropdownButtonFormField(
                                  value: _horaCita,
                                  isExpanded: true,
                                  onChanged: (DateTime? value) =>
                                      setState(() => _horaCita = value!),
                                  items: _horasDisponiblesCita,
                                  decoration: const InputDecoration(
                                    labelText: "Hora",
                                    border: OutlineInputBorder(),
                                    suffixIcon: Icon(Icons.access_time_rounded),
                                  ),
                                  validator: (value) => value == null
                                      ? "Seleccione una hora"
                                      : null,
                                ),
                                const SizedBox(height: 30),
                                ElevatedButton.icon(
                                  onPressed: _horasDisponiblesCita.isEmpty
                                      ? null
                                      : _agendarCita,
                                  icon: const Icon(Icons.calendar_month),
                                  label: const Text("Agendar cita"),
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
                            )),
                        const SizedBox(height: 40),
                        Row(
                          children: [
                            Text(
                              "Contacta al Vendedor",
                              style: textStyleTitulo,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.grey[700],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (_inmueble.agente.idUsuario != null)
                                      Text(
                                        "${_inmueble.agente.persona.nombre}",
                                        style: textStyleParrafo,
                                      ),
                                    if (_inmueble.usuario.empresa.idEmpresa !=
                                        null)
                                      Text(
                                        "Empresa: ${_inmueble.usuario.empresa.razonSocial}",
                                        style: textStyleParrafo,
                                      ),
                                    if (_inmueble.usuario.idUsuario != null)
                                      Text(
                                        "${_inmueble.usuario.persona.nombre} ${_inmueble.usuario.persona.apePaterno} ${_inmueble.usuario.persona.apeMaterno ?? ""}",
                                        style: textStyleParrafo,
                                      ),
                                    Text(
                                      _inmueble.usuario.telefono.toString(),
                                      style: textStyleParrafo,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: _abrirWhatsApp,
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
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
                                Icons.whatsapp,
                                size: 18,
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _inmuebleRepository = InmuebleRepository();
    _inmueble = Inmueble();
    _obtenerInmueble();
  }
}
