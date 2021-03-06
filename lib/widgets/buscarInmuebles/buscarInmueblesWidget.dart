import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homeshop/widgets/paginaInicioWidget.dart';

class BuscarInmueblesWidget extends StatefulWidget {
  BuscarInmueblesWidget({Key? key}) : super(key: key);

  @override
  State<BuscarInmueblesWidget> createState() => _BuscarInmueblesWidgetState();
}

class _BuscarInmueblesWidgetState extends State<BuscarInmueblesWidget> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController _precioController,
      _habitacionesController,
      _baniosController,
      _coloniaController;

  String? _validarCampo(valor, mensaje) =>
      valor!.trim().isEmpty ? mensaje : null;

  void _buscarInmuebles() {
    final route = MaterialPageRoute(
        builder: (BuildContext context) => PaginaInicioWidget());
    Navigator.push(context, route);
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final route = MaterialPageRoute(
          builder: (BuildContext context) => PaginaInicioWidget());
      Navigator.push(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Buscar Inmuebles",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _precioController,
                    decoration: const InputDecoration(
                        labelText: "Precio",
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.attach_money)),
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        _validarCampo(value, "Introduzca el precio"),
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
                        value, "Introduzca el n??mero de habitaciones"),
                  ),
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
                    validator: (value) =>
                        _validarCampo(value, "Introduzca el n??mero de ba??os"),
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
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: _buscarInmuebles,
                    icon: const Icon(Icons.search),
                    label: const Text("Buscar Inmuebleses"),
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
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _habitacionesController = TextEditingController();
    _baniosController = TextEditingController();
    _coloniaController = TextEditingController();
    _precioController = TextEditingController();
  }
}
