import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class Propiedad extends StatefulWidget {
  Propiedad(this.id, {Key? key}) : super(key: key);
  int id;

  @override
  State<Propiedad> createState() => _PropiedadState();
}

class _PropiedadState extends State<Propiedad> {
  TextStyle textStyleTitulo = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.red[600],
  );
  TextStyle textStyleParrafo = TextStyle(
    fontSize: 15,
    color: Colors.grey[700],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
              "Blvd. Universidad Tecnológica #225 Col. San Carlos CP. 37670")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
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
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: new Text(
                          "En Venta",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.red[600],
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          border: Border.all(
                            color: Color.fromARGB(255, 229, 57, 53),
                          ),
                        ),
                        padding: EdgeInsets.only(
                          left: 10,
                          top: 5,
                          right: 10,
                          bottom: 5,
                        ),
                      ),
                      Text(
                        "\$ 500,000 MXN",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Dirección",
                        style: textStyleTitulo,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Blvd. Universidad Tecnológica #225 Col. San Carlos CP. 37670",
                    style: textStyleParrafo,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Descripción",
                        style: textStyleTitulo,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Casa en fraccionamiento Santa Fé, sobre la Av. Vía Atlixcáyotl, frente a la La Vista, junto a Mercedes Benz, lugar tranquilo y seguro, a 5 min. de Centro Comercial Angelópolis, a 3min. del Tecnológico de Monterrey. Características: Planta Baja: Sala- comedor con grandes puertas corredizas de aluminio y vidrio que abren al jardín posterior de la casa. Oficina o estudio. Medio baño. Amplia cocina. Alacena. Cuarto de servicio y acceso de servicio. Estacionamiento para 2 autos. Planta Alta: 3 recámaras con baño y vestidor cada una, (family room) sala de tv, closet de blancos, cuarto de lavado y secado, área de tendido. Cisterna. BR",
                    style: textStyleParrafo,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 20),
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
                          ElementoDetalle("Cochera", Icons.garage, "Sí"),
                          const SizedBox(height: 10),
                          ElementoDetalle("Niveles/Piso", Icons.stairs, 2),
                          const SizedBox(height: 10),
                          ElementoDetalle("Dimensión", Icons.house, "210 m²"),
                          const SizedBox(height: 10),
                          ElementoDetalle("Internet", Icons.wifi, "Sí"),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElementoDetalle("Baños", Icons.bathtub, 2),
                          const SizedBox(height: 10),
                          ElementoDetalle(
                              "Estado", Icons.star_rate, "Excelente"),
                          const SizedBox(height: 10),
                          ElementoDetalle(
                              "Largo", Icons.arrow_upward, "20 metros"),
                          const SizedBox(height: 10),
                          ElementoDetalle(
                              "Luz", Icons.lightbulb_circle_sharp, "Sí"),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElementoDetalle("Habitaciones", Icons.bed, 3),
                          const SizedBox(height: 10),
                          ElementoDetalle(
                              "Edad", Icons.hourglass_bottom, "10 años"),
                          const SizedBox(height: 10),
                          ElementoDetalle(
                              "Ancho", Icons.arrow_back_outlined, "10 metros"),
                          const SizedBox(height: 10),
                          ElementoDetalle("Agua", Icons.water_drop, "Sí"),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton.icon(
                    onPressed: () {},
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
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Text(
                        "Contacta al vendedor",
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
                              Text(
                                "Josué Israel Durán Alberto",
                                style: textStyleParrafo,
                              ),
                              Text(
                                "4771234567",
                                style: textStyleParrafo,
                              ),
                            ],
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.whatsapp,
                          size: 18,
                        ),
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
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
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
}
