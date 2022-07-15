import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:homeshop/widgets/misCitas/citasWidget.dart';
import 'package:homeshop/widgets/paginaInicioWidget.dart';

class CitaWidget extends StatefulWidget {
  CitaWidget(this.id, {Key? key}) : super(key: key);
  int id;

  @override
  State<CitaWidget> createState() => _CitaWidgetState();
}

class _CitaWidgetState extends State<CitaWidget> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextStyle textStyleTitulo = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.red[600],
  );
  TextStyle textStyleParrafo = TextStyle(
    fontSize: 15,
    color: Colors.grey[700],
  );

  void _atenderCita() {
    final route =
        MaterialPageRoute(builder: (BuildContext context) => CitasWidget());
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cita para Publicación #2434")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Publicación #2434",
                    style: textStyleTitulo,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ImageSlideshow(
                children: [
                  Image.network(
                    "https://img.remediosdigitales.com/8e8f64/lo-de-que-comprar-una-casa-es-la-mejor-inversion-hay-generaciones-que-ya-no-lo-ven-ni-de-lejos---1/1366_2000.jpg",
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    "assets/icon/logo.png",
                    fit: BoxFit.cover,
                  ),
                  Image.network(
                    "https://img.remediosdigitales.com/8e8f64/lo-de-que-comprar-una-casa-es-la-mejor-inversion-hay-generaciones-que-ya-no-lo-ven-ni-de-lejos---1/1366_2000.jpg",
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    "assets/icon/logo.png",
                    fit: BoxFit.cover,
                  ),
                  Image.network(
                    "https://img.remediosdigitales.com/8e8f64/lo-de-que-comprar-una-casa-es-la-mejor-inversion-hay-generaciones-que-ya-no-lo-ven-ni-de-lejos---1/1366_2000.jpg",
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "Propietario:",
                    style: textStyleTitulo,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "Cesar Martinez Cabrera",
                style: textStyleParrafo,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "Fecha y hora:",
                    style: textStyleTitulo,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "20/02/2022 18:00",
                style: textStyleParrafo,
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _atenderCita,
                icon: const Icon(Icons.check),
                label: const Text("Atender cita"),
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
    );
  }
}
