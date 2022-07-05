import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:intl/intl.dart';

class PropiedadWidget extends StatefulWidget {
  PropiedadWidget(this.id, {Key? key}) : super(key: key);
  int id;

  @override
  State<PropiedadWidget> createState() => _PropiedadWidgetState();
}

class _PropiedadWidgetState extends State<PropiedadWidget> {
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
                            validator: (value) =>
                                value == null ? "Seleccione un día" : null,
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
                            validator: (value) =>
                                value == null ? "Seleccione una hora" : null,
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
