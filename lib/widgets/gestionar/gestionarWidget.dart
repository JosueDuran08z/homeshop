import 'package:flutter/material.dart';
import 'package:homeshop/widgets/roles/rolesWidget.dart';
import 'package:homeshop/widgets/usuarios/usuariosWidget.dart';

class GestionarWidget extends StatefulWidget {
  const GestionarWidget({Key? key}) : super(key: key);

  @override
  _GestionarWidgetState createState() => _GestionarWidgetState();
}

class _GestionarWidgetState extends State<GestionarWidget> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void _roles() {
    final route = MaterialPageRoute(
        builder: (BuildContext context) => MisRolesWidget());
    Navigator.push(context, route);
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final route = MaterialPageRoute(
          builder: (BuildContext context) => MisRolesWidget());
      Navigator.push(context, route);
    }
  }

  void _usuarios() {
    final route = MaterialPageRoute(
        builder: (BuildContext context) => UsuariosWidget());
    Navigator.push(context, route);
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final route = MaterialPageRoute(
          builder: (BuildContext context) => UsuariosWidget());
      Navigator.push(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          ElevatedButton.icon(
            onPressed: _roles,
            icon: const Icon(Icons.supervised_user_circle),
            label: const Text("Roles"),
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
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: _usuarios,
            icon: const Icon(Icons.person),
            label: const Text("Usuarios"),
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
    );
  }
}
