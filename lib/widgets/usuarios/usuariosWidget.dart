import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:homeshop/widgets/usuarios/agregarUsuariosWidget.dart';
import 'package:homeshop/widgets/usuarios/editarUsuariosWidget.dart';
import 'package:image_picker/image_picker.dart';

class UsuariosWidget extends StatefulWidget {
  const UsuariosWidget({Key? key}) : super(key: key);

  @override
  State<UsuariosWidget> createState() => _UsuariosWidgetState();
}

class _UsuariosWidgetState extends State<UsuariosWidget> {
  void _agregarUsuario() {
    final route = MaterialPageRoute(
        builder: (BuildContext context) => AgregarUsuariosWidget());
    Navigator.push(context, route);
  }

  void _editarUsuario(idUsuario) {
    final route = MaterialPageRoute(
        builder: (BuildContext context) =>
            EditarUsuariosWidget(idUsuario + 1));
    Navigator.push(context, route);
  }

  void _mostrarSnackbarEliminar(BuildContext context) {
    SnackBar snackbar = SnackBar(
      content: const Text(
        "!Usuario eliminado correctamente!",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.blue[600],
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void _mostrarModalEliminar(BuildContext context, int idUsuario) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text(
            "¿Estás seguro que deseas eliminar este registro?",
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
              onPressed: () => _eliminarUsuario(context, idUsuario),
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

  void _eliminarUsuario(context, int idUsuario) {
    print(idUsuario);
    Navigator.pop(context);
    _mostrarSnackbarEliminar(context);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
        title: const Text("Usuarios"),
    ),
    body: Column(
    children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Usuarios",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[600],
                ),
              ),
              ElevatedButton(
                onPressed: _agregarUsuario,
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
                child: Icon(
                  Icons.add,
                  size: 18,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 10,
            ),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Column(
                  children: [
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
                                "\Cesar Martínez Cabrera",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () => _editarUsuario(index),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.blue[600],
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
                                    child: Icon(
                                      Icons.edit,
                                      size: 18,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
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
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  const  Text(
                                    "cmartinezcabrera@gmail.com",
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
      ),
    );
  }
}
