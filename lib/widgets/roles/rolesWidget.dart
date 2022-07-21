import 'package:flutter/material.dart';
import 'package:homeshop/widgets/roles/agregarRolesWidget.dart';
import 'package:homeshop/widgets/roles/editarRolesWidget.dart';

class MisRolesWidget extends StatefulWidget {
  const MisRolesWidget({Key? key}) : super(key: key);

  @override
  State<MisRolesWidget> createState() => _MisRolesWidgetState();
}

class _MisRolesWidgetState extends State<MisRolesWidget> {
  void _agregarRol() {
    final route = MaterialPageRoute(
        builder: (BuildContext context) => AgregarRolWidget());
    Navigator.push(context, route);
  }

  void _editarRol(idRol) {
    final route = MaterialPageRoute(
        builder: (BuildContext context) => EditarRolWidget(idRol + 1));
    Navigator.push(context, route);
  }

  void _mostrarSnackbarEliminar(BuildContext context) {
    SnackBar snackbar = SnackBar(
      content: const Text(
        "!Rol eliminado correctamente!",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.blue[600],
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void _mostrarModalEliminar(BuildContext context, int idRol) {
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
              onPressed: () => _eliminarRol(context, idRol),
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

  void _eliminarRol(context, int idRol) {
    print(idRol);
    Navigator.pop(context);
    _mostrarSnackbarEliminar(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Roles"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Mis Roles",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[600],
                  ),
                ),
                ElevatedButton(
                  onPressed: _agregarRol,
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
                                  "\Vendedor",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () => _editarRol(index),
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
                                    const Text(
                                      "Este rol puede gestionar propiedades",
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
