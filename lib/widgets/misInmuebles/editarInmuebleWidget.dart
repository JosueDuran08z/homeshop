import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:homeshop/models/Inmueble.dart';
import 'package:homeshop/repository/InmuebleRepository.dart';
import 'package:homeshop/widgets/paginaInicioWidget.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:io';

class EditarInmuebleWidget extends StatefulWidget {
  EditarInmuebleWidget(this.idInmueble, {Key? key}) : super(key: key);
  int idInmueble;
  @override
  State<EditarInmuebleWidget> createState() =>
      _EditarInmuebleWidgetState(this.idInmueble);
}

class _EditarInmuebleWidgetState extends State<EditarInmuebleWidget> {
  _EditarInmuebleWidgetState(this.idInmueble);
  int idInmueble;
  late Inmueble _inmueble;
  late InmuebleRepository _inmuebleRepository;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextStyle textStylePregunta = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
    color: Colors.grey[800],
  );
  String? _tipoInmueble;
  final List<DropdownMenuItem<String>> _tiposInmuebles = [
    const DropdownMenuItem<String>(value: "casa", child: Text("Casa")),
    const DropdownMenuItem<String>(
        value: "departamento", child: Text("Departamento")),
    const DropdownMenuItem<String>(value: "edificio", child: Text("Edificio")),
    const DropdownMenuItem<String>(value: "terreno", child: Text("Terreno")),
  ];
  String _tipoOperacion = "";
  String _cochera = "";
  String _estacionamiento = "";
  String _enConstruccion = "";
  bool _agua = false, _luz = false, _internet = false;
  late TextEditingController _habitacionesController,
      _pisosController,
      _baniosController,
      _calleController,
      _coloniaController,
      _codPostalController,
      _numIntController,
      _numExtController,
      _largoController,
      _anchoController,
      _edadController,
      _descripcionController,
      _precioController;
  String? _estadoInstalaciones;
  final List<DropdownMenuItem<String>> _estadosInstalaciones = [
    const DropdownMenuItem<String>(
        value: "Excelente", child: Text("Excelente")),
    const DropdownMenuItem<String>(value: "Regular", child: Text("Regular")),
    const DropdownMenuItem<String>(value: "Malo", child: Text("Malo")),
  ];
  List<Image> _imagenes = <Image>[];
  List<String?> _imagenesBase64 = <String?>[];
  int _imagenActual = 0;

  String? _validarCampo(valor, mensaje) =>
      valor!.trim().isEmpty ? mensaje : null;

  Future _seleccionarImagen() async {
    XFile? imagen;
    imagen = await ImagePicker().pickImage(source: ImageSource.gallery);
    return imagen;
  }

  void _agregarImagen() {
    _seleccionarImagen().then((imagen) async {
      File imageFile = File(imagen!.path);
      Image image = Image.file(imageFile, fit: BoxFit.cover);
      Uint8List imagebytes = await imageFile.readAsBytes();
      String base64String = base64.encode(imagebytes);
      _imagenesBase64.add(base64String);

      Uint8List _bytesImage;
      _bytesImage = Base64Decoder().convert(base64String);
      Image image1 = Image.memory(_bytesImage, fit: BoxFit.cover);

      setState(() {
        _imagenes.add(image1);
      });
    });
  }

  void _cambiarOperacion(value) => setState(() => _tipoOperacion = value);
  void _cambiarValorCochera(value) => setState(() => _cochera = value);
  void _cambiarValorEstacionamiento(value) =>
      setState(() => _estacionamiento = value);
  void _cambiarValorConstruccion(value) =>
      setState(() => _enConstruccion = value);

  void _inicializarCampos() {
    setState(() {
      _tipoOperacion = _inmueble.operacion!;

      if (_inmueble.casa.idCasa != null) {
        _tipoInmueble = "casa";
        _cochera = _inmueble.casa.cochera! ? "S??" : "No";
        _internet = _inmueble.casa.internet!;
        _habitacionesController.text = _inmueble.casa.habitaciones!.toString();
        _pisosController.text = _inmueble.casa.pisos!.toString();
        _estadoInstalaciones = _inmueble.casa.estadoInstalaciones!;
        _edadController.text = _inmueble.casa.edad!.toString();
      } else if (_inmueble.departamento.idDepartamento != null) {
        _tipoInmueble = "departamento";
        _estacionamiento =
            _inmueble.departamento.estacionamiento! ? "S??" : "No";
        _internet = _inmueble.departamento.internet!;
        _habitacionesController.text =
            _inmueble.departamento.habitaciones!.toString();
        _pisosController.text = _inmueble.departamento.pisos!.toString();
        _estadoInstalaciones = _inmueble.departamento.estadoInstalaciones!;
        _edadController.text = _inmueble.departamento.edad!.toString();
      } else if (_inmueble.edificio.idEdificio != null) {
        _tipoInmueble = "edificio";
        _estacionamiento = _inmueble.edificio.estacionamiento! ? "S??" : "No";
        _internet = _inmueble.edificio.internet!;
        _habitacionesController.text =
            _inmueble.edificio.habitaciones!.toString();
        _pisosController.text = _inmueble.edificio.pisos!.toString();
        _estadoInstalaciones = _inmueble.edificio.estadoInstalaciones!;
        _edadController.text = _inmueble.edificio.edad!.toString();
      } else {
        _tipoInmueble = "terreno";
        _enConstruccion = _inmueble.terreno.enConstruccion! ? "S??" : "No";
      }

      _agua = _inmueble.agua! ? true : false;
      _luz = _inmueble.luz! ? true : false;
      _baniosController.text = _inmueble.banios!.toString();
      _calleController.text = _inmueble.calle!;
      _numIntController.text = _inmueble.numInterior!;

      if (_inmueble.numExterior != null) {
        _numExtController.text = _inmueble.numExterior!;
      }
      _coloniaController.text = _inmueble.colonia!;
      _codPostalController.text = _inmueble.cp!.toString();
      _largoController.text = _inmueble.largo!.toString();
      _anchoController.text = _inmueble.ancho!.toString();
      _descripcionController.text = _inmueble.descripcion!;
      _precioController.text = _inmueble.precio!.toString();

      Base64Decoder base64Decoder = const Base64Decoder();

      _imagenesBase64 = [
        _inmueble.imagen1,
        if (_inmueble.imagen2 != null) _inmueble.imagen2,
        if (_inmueble.imagen3 != null) _inmueble.imagen3,
        if (_inmueble.imagen4 != null) _inmueble.imagen4,
        if (_inmueble.imagen5 != null) _inmueble.imagen5
      ];

      _imagenes = [
        Image.memory(base64Decoder.convert(_inmueble.imagen1!),
            fit: BoxFit.cover),
        if (_inmueble.imagen2 != null)
          Image.memory(base64Decoder.convert(_inmueble.imagen2!),
              fit: BoxFit.cover),
        if (_inmueble.imagen3 != null)
          Image.memory(base64Decoder.convert(_inmueble.imagen3!),
              fit: BoxFit.cover),
        if (_inmueble.imagen4 != null)
          Image.memory(base64Decoder.convert(_inmueble.imagen4!),
              fit: BoxFit.cover),
        if (_inmueble.imagen5 != null)
          Image.memory(base64Decoder.convert(_inmueble.imagen5!),
              fit: BoxFit.cover),
      ];
    });
  }

  void _obtenerInmueble(int idInmueble) {
    try {
      Future<http.Response?> response =
          _inmuebleRepository.obtenerPorId(idInmueble);

      response.then((http.Response? response) {
        var responseData = jsonDecode(response!.body);

        if (response.statusCode == 200) {
          _inmueble.setInmueble(responseData);
          _inicializarCampos();
        } else {
          _mostrarSnackbar(responseData["mensaje"], Colors.red[900]);
        }
      });
    } catch (e) {
      _mostrarSnackbar(
          "??Ocurri?? un error inesperado! Vuelve a intentarlo m??s tarde.",
          Colors.red[900]);
    }
  }

  void _editarInmueble() {
    if (_imagenes.isEmpty) {
      _mostrarSnackbar("!Seleccione por lo menos una imagen!", Colors.red[900]);
      return;
    }

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        _inmueble.descripcion = _descripcionController.text.trim();
        _inmueble.calle = _calleController.text.trim();
        _inmueble.numInterior = _numIntController.text.trim();
        _inmueble.numExterior = _numExtController.text.trim();
        _inmueble.colonia = _coloniaController.text.trim();
        _inmueble.cp = int.parse(_codPostalController.text);
        _inmueble.imagen1 = _imagenesBase64[0];
        _inmueble.imagen2 = _imagenes.length > 1 ? _imagenesBase64[1] : null;
        _inmueble.imagen3 = _imagenes.length > 2 ? _imagenesBase64[2] : null;
        _inmueble.imagen4 = _imagenes.length > 3 ? _imagenesBase64[3] : null;
        _inmueble.imagen5 = _imagenes.length > 4 ? _imagenesBase64[4] : null;
        _inmueble.banios = int.parse(_baniosController.text);
        _inmueble.ancho = double.parse(_largoController.text);
        _inmueble.largo = double.parse(_largoController.text);
        _inmueble.agua = _agua;
        _inmueble.luz = _luz;
        _inmueble.operacion = _tipoOperacion;
        _inmueble.precio = double.parse(_precioController.text);

        if (_tipoInmueble == "casa") {
          _inmueble.casa.cochera = _cochera == "S??" ? true : false;
          _inmueble.casa.internet = _internet;
          _inmueble.casa.habitaciones = int.parse(_habitacionesController.text);
          _inmueble.casa.pisos = int.parse(_pisosController.text);
          _inmueble.casa.edad = int.parse(_edadController.text);
          _inmueble.casa.estadoInstalaciones = _estadoInstalaciones;
        } else if (_tipoInmueble == "departamento") {
          _inmueble.departamento.estacionamiento =
              _estacionamiento == "S??" ? true : false;
          _inmueble.departamento.internet = _internet;
          _inmueble.departamento.habitaciones =
              int.parse(_habitacionesController.text);
          _inmueble.departamento.pisos = int.parse(_pisosController.text);
          _inmueble.departamento.edad = int.parse(_edadController.text);
          _inmueble.departamento.estadoInstalaciones = _estadoInstalaciones;
        } else if (_tipoInmueble == "edificio") {
          _inmueble.edificio.estacionamiento =
              _estacionamiento == "S??" ? true : false;
          _inmueble.edificio.internet = _internet;
          _inmueble.edificio.habitaciones =
              int.parse(_habitacionesController.text);
          _inmueble.edificio.pisos = int.parse(_pisosController.text);
          _inmueble.edificio.edad = int.parse(_edadController.text);
          _inmueble.edificio.estadoInstalaciones = _estadoInstalaciones;
        } else {
          _inmueble.terreno.enConstruccion =
              _enConstruccion == "S??" ? true : false;
        }

        Future<http.Response?> response =
            _inmuebleRepository.editar(_inmueble, _tipoInmueble!);

        response.then((http.Response? response) {
          var responseData = jsonDecode(response!.body);

          if (response.statusCode == 200) {
            final route = MaterialPageRoute(
                builder: (BuildContext context) =>
                    PaginaInicioWidget(paginaInicio: 3));
            Navigator.push(context, route);
            _mostrarSnackbar(responseData["mensaje"], Colors.green[700]);
          } else {
            _mostrarSnackbar(responseData["mensaje"], Colors.red[900]);
          }
        });
      } catch (e) {
        _mostrarSnackbar(
            "??Ocurri?? un error inesperado! Vuelve a intentarlo m??s tarde.",
            Colors.red[900]);
      }
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

  void _editarImagen() {
    _seleccionarImagen().then((imagen) async {
      File imageFile = File(imagen!.path);
      Image image = Image.file(imageFile, fit: BoxFit.cover);
      Uint8List imagebytes = await imageFile.readAsBytes();
      String base64String = base64.encode(imagebytes);
      _imagenesBase64[_imagenActual] = base64String;

      Uint8List _bytesImage;
      _bytesImage = Base64Decoder().convert(base64String);
      Image image1 = Image.memory(_bytesImage, fit: BoxFit.cover);

      setState(() {
        _imagenes[_imagenActual] = image1;
      });
    }).catchError((e) {
      _mostrarSnackbar(
          "??Ocurri?? un error inesperado! Vuelve a intentarlo m??s tarde.",
          Colors.red[900]);
    });
  }

  void _eliminarImagen() => setState(() {
        if (_imagenActual == -1) _imagenActual = 0;
        _imagenesBase64.removeAt(_imagenActual);
        _imagenes.removeAt(_imagenActual);
        _imagenActual = _imagenes.isEmpty ? 0 : _imagenActual - 1;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Inmueble"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                if (_imagenes.isNotEmpty)
                  ImageSlideshow(
                    initialPage: _imagenActual,
                    onPageChanged: (index) =>
                        setState(() => _imagenActual = index),
                    children: _imagenes,
                  ),
                SizedBox(height: _imagenes.isEmpty ? 0 : 20),
                if (_imagenes.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _editarImagen,
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
                          Icons.edit,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: _eliminarImagen,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red[600],
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
                          Icons.delete,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: _imagenes.isEmpty ? 0 : 20),
                if (_imagenes.length < 5)
                  ElevatedButton.icon(
                    onPressed: _agregarImagen,
                    icon: const Icon(Icons.add),
                    label: const Text("A??adir Imagen"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue[800],
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
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "Operaci??n",
                      style: textStylePregunta,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        title: const Text("Renta"),
                        leading: Radio(
                          value: "Renta",
                          groupValue: _tipoOperacion,
                          onChanged: _cambiarOperacion,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        title: const Text("Venta"),
                        leading: Radio(
                          value: "Venta",
                          groupValue: _tipoOperacion,
                          onChanged: _cambiarOperacion,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField(
                  value: _tipoInmueble,
                  isExpanded: true,
                  onChanged: (String? value) =>
                      setState(() => _tipoInmueble = value!),
                  items: _tiposInmuebles,
                  decoration: const InputDecoration(
                    labelText: "Tipo de Inmueble",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.maps_home_work),
                  ),
                ),
                if (_tipoInmueble != null && _tipoInmueble != "terreno")
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            "??Cuenta con ${_tipoInmueble == "casa" ? "Cochera" : "Estacionamiento"}?",
                            style: textStylePregunta,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              title: const Text("S??"),
                              leading: Radio(
                                value: "S??",
                                groupValue: _tipoInmueble == "casa"
                                    ? _cochera
                                    : _estacionamiento,
                                onChanged: _tipoInmueble == "casa"
                                    ? _cambiarValorCochera
                                    : _cambiarValorEstacionamiento,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              title: const Text("No"),
                              leading: Radio(
                                value: "No",
                                groupValue: _tipoInmueble == "casa"
                                    ? _cochera
                                    : _estacionamiento,
                                onChanged: _tipoInmueble == "casa"
                                    ? _cambiarValorCochera
                                    : _cambiarValorEstacionamiento,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                if (_tipoInmueble != null)
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            "Servicios",
                            style: textStylePregunta,
                          ),
                        ],
                      ),
                      CheckboxListTile(
                        contentPadding: const EdgeInsets.all(0),
                        title: const Text("Agua"),
                        value: _agua,
                        onChanged: (bool? value) =>
                            setState(() => _agua = value!),
                      ),
                      CheckboxListTile(
                        contentPadding: const EdgeInsets.all(0),
                        title: const Text("Luz"),
                        value: _luz,
                        onChanged: (bool? value) =>
                            setState(() => _luz = value!),
                      ),
                      if (_tipoInmueble != null && _tipoInmueble != "terreno")
                        CheckboxListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: const Text("Internet"),
                          value: _internet,
                          onChanged: (bool? value) =>
                              setState(() => _internet = value!),
                        ),
                    ],
                  ),
                if (_tipoInmueble != null && _tipoInmueble != "terreno")
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _habitacionesController,
                        decoration: const InputDecoration(
                          labelText: "Habitaciones",
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.bed),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) => _validarCampo(
                            value, "Introduzca el n??mero de habitaciones"),
                      ),
                    ],
                  ),
                if (_tipoInmueble != null && _tipoInmueble != "terreno")
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _pisosController,
                        decoration: const InputDecoration(
                          labelText: "Pisos",
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.stairs),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) => _validarCampo(
                            value, "Introduzca el n??mero de pisos"),
                      ),
                    ],
                  ),
                if (_tipoInmueble == "terreno")
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            "??Est?? en construcci??n?",
                            style: textStylePregunta,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              title: const Text("S??"),
                              leading: Radio(
                                value: "S??",
                                groupValue: _enConstruccion,
                                onChanged: _cambiarValorConstruccion,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              title: const Text("No"),
                              leading: Radio(
                                value: "No",
                                groupValue: _enConstruccion,
                                onChanged: _cambiarValorConstruccion,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                if (_tipoInmueble != null)
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _baniosController,
                        decoration: const InputDecoration(
                          labelText: "Ba??os",
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.bathtub),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) => _validarCampo(
                            value, "Introduzca el n??mero de ba??os"),
                      ),
                    ],
                  ),
                if (_tipoInmueble != null && _tipoInmueble != "terreno")
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      DropdownButtonFormField(
                        value: _estadoInstalaciones,
                        isExpanded: true,
                        onChanged: (String? value) =>
                            setState(() => _estadoInstalaciones = value!),
                        items: _estadosInstalaciones,
                        decoration: const InputDecoration(
                          labelText: "Estado Instalaciones",
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.star_rate),
                        ),
                        validator: (value) =>
                            value == null ? "Seleccione una opci??n" : null,
                      ),
                    ],
                  ),
                if (_tipoInmueble != null)
                  Column(
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
                        validator: (value) =>
                            _validarCampo(value, "Introduzca la colonia"),
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
                              validator: (value) => _validarCampo(
                                  value, "Introduzca el n??mero interior"),
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
                          labelText: "C??digo Postal",
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.location_on_outlined),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) =>
                            _validarCampo(value, "Introduzca el c??digo postal"),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _largoController,
                              decoration: const InputDecoration(
                                labelText: "Largo (m)",
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.arrow_upward),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) =>
                                  _validarCampo(value, "Introduzca el largo"),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              controller: _anchoController,
                              decoration: const InputDecoration(
                                labelText: "Ancho (m)",
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.arrow_back_outlined),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) =>
                                  _validarCampo(value, "Introduzca el ancho"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                if (_tipoInmueble != null && _tipoInmueble != "terreno")
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _edadController,
                        decoration: const InputDecoration(
                          labelText: "Edad Inmueble",
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.hourglass_bottom),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) => _validarCampo(
                            value, "Introduzca la edad del inmueble"),
                      ),
                    ],
                  ),
                if (_tipoInmueble != null)
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _descripcionController,
                        decoration: const InputDecoration(
                          labelText: "Descripci??n",
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.description),
                        ),
                        maxLines: 4,
                        validator: (value) =>
                            _validarCampo(value, "Introduzca la descripci??n"),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _precioController,
                        decoration: const InputDecoration(
                          labelText: "Precio",
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.attach_money),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            _validarCampo(value, "Introduzca el precio"),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton.icon(
                        onPressed: _editarInmueble,
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
                    ],
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
    _inmueble = Inmueble();
    _inmuebleRepository = InmuebleRepository();
    _obtenerInmueble(idInmueble);
    _habitacionesController = TextEditingController();
    _pisosController = TextEditingController();
    _baniosController = TextEditingController();
    _calleController = TextEditingController();
    _coloniaController = TextEditingController();
    _codPostalController = TextEditingController();
    _numIntController = TextEditingController();
    _numExtController = TextEditingController();
    _largoController = TextEditingController();
    _anchoController = TextEditingController();
    _edadController = TextEditingController();
    _descripcionController = TextEditingController();
    _precioController = TextEditingController();
  }
}
