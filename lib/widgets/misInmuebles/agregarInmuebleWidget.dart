import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:homeshop/models/Inmueble.dart';
import 'package:homeshop/repository/InmuebleRepository.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';

class AgregarInmuebleWidget extends StatefulWidget {
  AgregarInmuebleWidget({Key? key}) : super(key: key);

  @override
  State<AgregarInmuebleWidget> createState() => _AgregarInmuebleWidgetState();
}

class _AgregarInmuebleWidgetState extends State<AgregarInmuebleWidget> {
  late Inmueble _inmueble;
  late Future<SharedPreferences> _prefs;
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

  void _agregarInmueble() {
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
          _inmueble.casa.cochera = _cochera == "Sí" ? true : false;
          _inmueble.casa.internet = _internet;
          _inmueble.casa.habitaciones = int.parse(_habitacionesController.text);
          _inmueble.casa.pisos = int.parse(_pisosController.text);
          _inmueble.casa.edad = int.parse(_edadController.text);
          _inmueble.casa.estadoInstalaciones = _estadoInstalaciones;
        } else if (_tipoInmueble == "departamento") {
          _inmueble.departamento.estacionamiento =
              _estacionamiento == "Sí" ? true : false;
          _inmueble.departamento.internet = _internet;
          _inmueble.departamento.habitaciones =
              int.parse(_habitacionesController.text);
          _inmueble.departamento.pisos = int.parse(_pisosController.text);
          _inmueble.departamento.edad = int.parse(_edadController.text);
          _inmueble.departamento.estadoInstalaciones = _estadoInstalaciones;
        } else if (_tipoInmueble == "edificio") {
          _inmueble.edificio.estacionamiento =
              _estacionamiento == "Sí" ? true : false;
          _inmueble.edificio.internet = _internet;
          _inmueble.edificio.habitaciones =
              int.parse(_habitacionesController.text);
          _inmueble.edificio.pisos = int.parse(_pisosController.text);
          _inmueble.edificio.edad = int.parse(_edadController.text);
          _inmueble.edificio.estadoInstalaciones = _estadoInstalaciones;
        } else {
          _inmueble.terreno.enConstruccion =
              _enConstruccion == "Sí" ? true : false;
        }

        Future<http.Response?> response =
            _inmuebleRepository.agregar(_inmueble, _tipoInmueble!);

        response.then((http.Response? response) {
          var responseData = jsonDecode(response!.body);

          if (response.statusCode == 201) {
            Navigator.pop(context);
            _mostrarSnackbar(responseData["mensaje"], Colors.blue[800]);
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
          "¡Ocurrió un error inesperado! Vuelve a intentarlo más tarde.",
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
        title: const Text("Agregar Inmueble"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _imagenes.isEmpty
                    ? Container()
                    : ImageSlideshow(
                        initialPage: 2,
                        onPageChanged: (index) =>
                            setState(() => _imagenActual = index),
                        children: _imagenes,
                      ),
                SizedBox(height: _imagenes.isEmpty ? 0 : 20),
                _imagenes.isEmpty
                    ? Container()
                    : Row(
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
                _imagenes.length < 5
                    ? ElevatedButton.icon(
                        onPressed: _agregarImagen,
                        icon: const Icon(Icons.add),
                        label: const Text("Añadir Imagen"),
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
                      )
                    : Container(),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "Operación",
                      style: textStylePregunta,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        contentPadding: EdgeInsets.all(0),
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
                        contentPadding: EdgeInsets.all(0),
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
                _tipoInmueble != null && _tipoInmueble != "terreno"
                    ? Column(
                        children: [
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                "¿Cuenta con ${_tipoInmueble == "casa" ? "Cochera" : "Estacionamiento"}?",
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
                                  title: const Text("Sí"),
                                  leading: Radio(
                                    value: "Sí",
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
                      )
                    : Container(),
                _tipoInmueble != null
                    ? Column(
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
                          _tipoInmueble != null && _tipoInmueble != "terreno"
                              ? CheckboxListTile(
                                  contentPadding: const EdgeInsets.all(0),
                                  title: const Text("Internet"),
                                  value: _internet,
                                  onChanged: (bool? value) =>
                                      setState(() => _internet = value!),
                                )
                              : Container(),
                        ],
                      )
                    : Container(),
                _tipoInmueble != null && _tipoInmueble != "terreno"
                    ? Column(
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
                                value, "Introduzca el número de habitaciones"),
                          ),
                        ],
                      )
                    : Container(),
                _tipoInmueble != null && _tipoInmueble != "terreno"
                    ? Column(
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
                                value, "Introduzca el número de pisos"),
                          ),
                        ],
                      )
                    : Container(),
                _tipoInmueble == "terreno"
                    ? Column(
                        children: [
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                "¿Está en construcción?",
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
                                  title: const Text("Sí"),
                                  leading: Radio(
                                    value: "Sí",
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
                      )
                    : Container(),
                _tipoInmueble != null
                    ? Column(
                        children: [
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _baniosController,
                            decoration: const InputDecoration(
                              labelText: "Baños",
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.bathtub),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (value) => _validarCampo(
                                value, "Introduzca el número de baños"),
                          ),
                        ],
                      )
                    : Container(),
                _tipoInmueble != null && _tipoInmueble != "terreno"
                    ? Column(
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
                                value == null ? "Seleccione una opción" : null,
                          ),
                        ],
                      )
                    : Container(),
                _tipoInmueble != null
                    ? Column(
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
                                      value, "Introduzca el número interior"),
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
                              labelText: "Código Postal",
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.location_on_outlined),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (value) => _validarCampo(
                                value, "Introduzca el código postal"),
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
                                  validator: (value) => _validarCampo(
                                      value, "Introduzca el largo"),
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
                                  validator: (value) => _validarCampo(
                                      value, "Introduzca el ancho"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Container(),
                _tipoInmueble != null && _tipoInmueble != "terreno"
                    ? Column(
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
                      )
                    : Container(),
                _tipoInmueble != null
                    ? Column(
                        children: [
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _descripcionController,
                            decoration: const InputDecoration(
                              labelText: "Descripción",
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.description),
                            ),
                            maxLines: 4,
                            validator: (value) => _validarCampo(
                                value, "Introduzca la descripción"),
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
                            onPressed: _agregarInmueble,
                            icon: const Icon(Icons.add),
                            label: const Text("Agregar Inmueble"),
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
                      )
                    : Container(),
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
    _prefs = SharedPreferences.getInstance();
    _prefs
        .then((pref) => _inmueble.usuario.idUsuario = pref.getInt("idUsuario"));
    _inmuebleRepository = InmuebleRepository();
    _habitacionesController = TextEditingController(text: "5");
    _pisosController = TextEditingController(text: "2");
    _baniosController = TextEditingController(text: "3");
    _calleController = TextEditingController(text: "Eta");
    _coloniaController = TextEditingController(text: "Valle del Sahuan");
    _codPostalController = TextEditingController(text: "35000");
    _numIntController = TextEditingController(text: "125");
    _numExtController = TextEditingController();
    _largoController = TextEditingController(text: "23");
    _anchoController = TextEditingController(text: "10");
    _edadController = TextEditingController(text: "15");
    _descripcionController =
        TextEditingController(text: "Ninguna descripción interesante");
    _precioController = TextEditingController(text: "650000");
  }
}
