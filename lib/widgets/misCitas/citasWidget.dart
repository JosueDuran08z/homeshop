import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:homeshop/widgets/misCitas/agregarCitaWidget.dart';
import 'package:homeshop/widgets/misCitas/citaWidget.dart';

class CitasWidget extends StatefulWidget {
  const CitasWidget({Key? key}) : super(key: key);

  @override
  State<CitasWidget> createState() => _CitasWidgetState();
}

class _CitasWidgetState extends State<CitasWidget> {

  void _mostrarSnackbarEliminar(BuildContext context) {
    SnackBar snackbar = SnackBar(
      content: const Text(
        "!Cita eliminada correctamente!",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.blue[600],
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void _mostrarModalEliminar(BuildContext context, int idCita) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text(
            "¿Estás seguro que deseas eliminar esta cita?",
            textAlign: TextAlign.justify,
            style: TextStyle(
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
              onPressed: () => _eliminarCita(context, idCita),
              child: Text(
                "Aceptar",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[600],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _eliminarCita(context, int idCita) {
    print(idCita);
    Navigator.pop(context);
    _mostrarSnackbarEliminar(context);
  }

  void _mostrarCita(id) {
    final route = MaterialPageRoute(
        builder: (BuildContext context) => CitaWidget(id));
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 45),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Mis Citas",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[600],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => _mostrarCita(index),
                  child: Card(
                    child: Column(
                      children: [
                        ImageSlideshow(
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
                                  Container(
                                    child: new Text(
                                      "Publicacion #2434",
                                      style: TextStyle(color: Colors.red[700]),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                      border: Border.all(
                                        color: Colors.red,
                                      ),
                                    ),
                                    padding: EdgeInsets.only(
                                      left: 10,
                                      top: 5,
                                      right: 10,
                                      bottom: 5,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => _mostrarModalEliminar(
                                        context, index + 1),
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
                              const Text(
                                "Cesar Martinez Cabrera",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Fecha y hora: 20/02/2022 18:00",
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
        )
      ],
    );
  }
}
