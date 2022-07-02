import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:homeshop/widgets/propiedad.dart';

class Propiedades extends StatefulWidget {
  Propiedades({Key? key}) : super(key: key);

  @override
  State<Propiedades> createState() => _PropiedadesState();
}

class _PropiedadesState extends State<Propiedades> {
  void _mostrarPropiedad(id) {
    final route =
        MaterialPageRoute(builder: (BuildContext context) => Propiedad(id));
    Navigator.push(context, route);
  }

  void _abrirWhatsApp() {
    print("Whatsapp");
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () => _mostrarPropiedad(index),
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
                          const Text(
                            "\$ 500,000",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            child: new Text(
                              "En Venta",
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
                            onPressed: _abrirWhatsApp,
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
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Blvd. Universidad Tecnológica #225 Col. San Carlos CP. 37670",
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
    );
  }
}
