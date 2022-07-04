import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:homeshop/widgets/misPropiedades/misPropiedadesWidget.dart';

class AgregarPropiedadWidget extends StatefulWidget {
  AgregarPropiedadWidget({Key? key}) : super(key: key);

  @override
  State<AgregarPropiedadWidget> createState() => _AgregarPropiedadWidgetState();
}

class _AgregarPropiedadWidgetState extends State<AgregarPropiedadWidget> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextStyle textStylePregunta = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
    color: Colors.grey[800],
  );
  late TextEditingController _calleController;
  late TextEditingController _coloniaController;
  String _tipoOperacion = "";
  bool _agua = false;
  bool _luz = false;
  bool _internet = false;
  Widget _imageSlider = Container();
  double _alturaSB = 0;

  String? _validarCampo(valor, mensaje) =>
      valor!.trim().isEmpty ? mensaje : null;

  void _agregarImagen() {
    setState(() {
      _imageSlider = ImageSlideshow(
        children: [
          Image.network(
            "https://img.remediosdigitales.com/8e8f64/lo-de-que-comprar-una-casa-es-la-mejor-inversion-hay-generaciones-que-ya-no-lo-ven-ni-de-lejos---1/1366_2000.jpg",
            fit: BoxFit.cover,
          ),
          Image.network(
            "https://th.bing.com/th/id/R.2c76042f56bf81ef78c51089192d5d10?rik=9Va9wLV7TzGRYw&pid=ImgRaw&r=0",
            fit: BoxFit.cover,
          ),
          Image.network(
            "https://img.remediosdigitales.com/8e8f64/lo-de-que-comprar-una-casa-es-la-mejor-inversion-hay-generaciones-que-ya-no-lo-ven-ni-de-lejos---1/1366_2000.jpg",
            fit: BoxFit.cover,
          ),
          Image.network(
            "https://th.bing.com/th/id/R.2c76042f56bf81ef78c51089192d5d10?rik=9Va9wLV7TzGRYw&pid=ImgRaw&r=0",
            fit: BoxFit.cover,
          ),
          Image.network(
            "https://img.remediosdigitales.com/8e8f64/lo-de-que-comprar-una-casa-es-la-mejor-inversion-hay-generaciones-que-ya-no-lo-ven-ni-de-lejos---1/1366_2000.jpg",
            fit: BoxFit.cover,
          ),
        ],
      );
      _alturaSB = 20;
    });
  }

  void _cambiarOperacion(value) => setState(() => _tipoOperacion = value);

  void _agregarPropiedad() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final route = MaterialPageRoute(
          builder: (BuildContext context) => MisPropiedadesWidget());
      Navigator.push(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agregar Propiedad"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _imageSlider,
                SizedBox(height: _alturaSB),
                ElevatedButton.icon(
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
                ),
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
                          groupValue: _tipoOperacion,
                          onChanged: _cambiarOperacion,
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
                      "Servicios",
                      style: textStylePregunta,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 0, right: 10),
                        title: const Text("Agua"),
                        value: _agua,
                        onChanged: (bool? value) =>
                            setState(() => _agua = value!),
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 10, right: 10),
                        title: const Text("Luz"),
                        value: _luz,
                        onChanged: (bool? value) =>
                            setState(() => _luz = value!),
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 10, right: 0),
                        title: const Text("Internet"),
                        value: _internet,
                        onChanged: (bool? value) =>
                            setState(() => _internet = value!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _coloniaController,
                  decoration: const InputDecoration(
                    labelText: "Habitaciones",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.bed),
                  ),
                  validator: (value) => _validarCampo(
                      value, "Introduzca el número de habitaciones"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _coloniaController,
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
                  controller: _coloniaController,
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
                TextFormField(
                  controller: _calleController,
                  decoration: const InputDecoration(
                    labelText: "Estado Instalaciones",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.star_rate),
                  ),
                  validator: (value) =>
                      _validarCampo(value, "Introduzca la calle"),
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
                        controller: _coloniaController,
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
                        controller: _coloniaController,
                        decoration: const InputDecoration(
                          labelText: "# Exterior",
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.numbers),
                        ),
                        validator: (value) => _validarCampo(
                            value, "Introduzca el número exterior"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _coloniaController,
                  decoration: const InputDecoration(
                    labelText: "Código Postal",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.location_on_outlined),
                  ),
                  validator: (value) =>
                      _validarCampo(value, "Introduzca el número exterior"),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _coloniaController,
                        decoration: const InputDecoration(
                          labelText: "Largo (m)",
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.arrow_upward),
                        ),
                        validator: (value) => _validarCampo(
                            value, "Introduzca el número interior"),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        controller: _coloniaController,
                        decoration: const InputDecoration(
                          labelText: "Ancho (m)",
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.arrow_back_outlined),
                        ),
                        validator: (value) => _validarCampo(
                            value, "Introduzca el número exterior"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _coloniaController,
                  decoration: const InputDecoration(
                    labelText: "Edad Propiedad",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.hourglass_bottom),
                  ),
                  validator: (value) => _validarCampo(
                      value, "Introduzca la edad de la propiedad"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _coloniaController,
                  decoration: const InputDecoration(
                    labelText: "Descripción",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.description),
                  ),
                  maxLines: 4,
                  validator: (value) => _validarCampo(
                      value, "Introduzca la edad de la propiedad"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _coloniaController,
                  decoration: const InputDecoration(
                    labelText: "Precio",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.attach_money),
                  ),
                  validator: (value) =>
                      _validarCampo(value, "Introduzca la colonia"),
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: _agregarPropiedad,
                  icon: const Icon(Icons.add),
                  label: const Text("Agregar Propiedad"),
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
    _calleController = TextEditingController();
    _coloniaController = TextEditingController();
  }
}
