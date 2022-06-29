import 'package:flutter/material.dart';

class Propiedades extends StatefulWidget {
  Propiedades({Key? key}) : super(key: key);

  @override
  State<Propiedades> createState() => _PropiedadesState();
}

class _PropiedadesState extends State<Propiedades> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Column(
            children: [
              Image.asset("assets/icon/logo.png"),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 30,
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
                            style: TextStyle(color: Colors.red[600]),
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
                        ElevatedButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.whatsapp,
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              padding: const EdgeInsets.only(
                                top: 15,
                                bottom: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
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
        );
      },
    );
  }
}
