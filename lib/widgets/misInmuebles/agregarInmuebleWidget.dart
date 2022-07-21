import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:image_picker/image_picker.dart';

class AgregarInmuebleWidget extends StatefulWidget {
  AgregarInmuebleWidget({Key? key}) : super(key: key);

  @override
  State<AgregarInmuebleWidget> createState() => _AgregarInmuebleWidgetState();
}

class _AgregarInmuebleWidgetState extends State<AgregarInmuebleWidget> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextStyle textStylePregunta = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
    color: Colors.grey[800],
  );
  String _tipoOperacion = "";
  String _cochera = "";
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
  int _imagenActual = 0;

  String? _validarCampo(valor, mensaje) =>
      valor!.trim().isEmpty ? mensaje : null;

  Future _seleccionarImagen() async {
    XFile? imagen;
    imagen = await ImagePicker().pickImage(source: ImageSource.gallery);
    return imagen;
  }

  void _agregarImagen() {
    _seleccionarImagen().then((imagen) {
      setState(() {
        /* _imagenes.add(
          Image.file(
            File(imagen!.path),
            fit: BoxFit.cover,
          ),
        ); */
        _imagenes.add(Image.network(
          _imagenes.length % 2 == 0
              ? "https://img.remediosdigitales.com/8e8f64/lo-de-que-comprar-una-casa-es-la-mejor-inversion-hay-generaciones-que-ya-no-lo-ven-ni-de-lejos---1/1366_2000.jpg"
              : "https://th.bing.com/th/id/R.2c76042f56bf81ef78c51089192d5d10?rik=9Va9wLV7TzGRYw&pid=ImgRaw&r=0",
          fit: BoxFit.cover,
        ));
      });
    }).catchError((e) => print("Error"));
  }

  void _cambiarOperacion(value) => setState(() => _tipoOperacion = value);
  void _cambiarValorCochera(value) => setState(() => _cochera = value);

  void _agregarInmueble() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Navigator.pop(context);
      SnackBar snackbar = SnackBar(
        content: const Text(
          "!Inmueble agregado correctamente!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue[600],
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  void _editarImagen() {
    _seleccionarImagen().then((imagen) {
      setState(() {
        /* _imagenes[_imagenActual] = Image.file(
          File(imagen!.path),
          fit: BoxFit.cover,
        ); */
        _imagenes[_imagenActual] =
            Image.asset("assets/icon/logo.png", fit: BoxFit.cover);
      });
    }).catchError((e) => print("Error"));
  }

  void _eliminarImagen() => setState(() {
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
                              primary: Colors.blue[600],
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
                          primary: Colors.blue[600],
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
                Row(
                  children: [
                    Text(
                      "¿Cuenta con Cochera?",
                      style: textStylePregunta,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: const Text("Sí"),
                        leading: Radio(
                          value: "Sí",
                          groupValue: _cochera,
                          onChanged: _cambiarValorCochera,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: const Text("No"),
                        leading: Radio(
                          value: "No",
                          groupValue: _cochera,
                          onChanged: _cambiarValorCochera,
                        ),
                      ),
                    ),
                  ],
                ),
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
                  onChanged: (bool? value) => setState(() => _agua = value!),
                ),
                CheckboxListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text("Luz"),
                  value: _luz,
                  onChanged: (bool? value) => setState(() => _luz = value!),
                ),
                CheckboxListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text("Internet"),
                  value: _internet,
                  onChanged: (bool? value) =>
                      setState(() => _internet = value!),
                ),
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
                  validator: (value) =>
                      _validarCampo(value, "Introduzca el número de pisos"),
                ),
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
                  validator: (value) =>
                      _validarCampo(value, "Introduzca el número de baños"),
                ),
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
                  validator: (value) =>
                      _validarCampo(value, "Introduzca el código postal"),
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
                  validator: (value) =>
                      _validarCampo(value, "Introduzca la edad del inmueble"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _descripcionController,
                  decoration: const InputDecoration(
                    labelText: "Descripción",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.description),
                  ),
                  maxLines: 4,
                  validator: (value) =>
                      _validarCampo(value, "Introduzca la descripción"),
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
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
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
