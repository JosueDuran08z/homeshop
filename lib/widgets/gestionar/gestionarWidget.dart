import 'package:flutter/material.dart';
import 'package:homeshop/widgets/cuenta/cambiarContrase%C3%B1aWidget.dart';
import 'package:homeshop/widgets/cuenta/datosPersonaleWidget.dart';
import 'package:homeshop/widgets/horarios/horariosWidget.dart';
import 'package:homeshop/widgets/login/loginWidget.dart';
import 'package:homeshop/widgets/roles/rolesWidget.dart';
import 'package:homeshop/widgets/usuarios/usuariosWidget.dart';

class GestionarWidget extends StatefulWidget {
  const GestionarWidget({Key? key}) : super(key: key);

  @override
  _GestionarWidgetState createState() => _GestionarWidgetState();
}

class _GestionarWidgetState extends State<GestionarWidget> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void _datosPersonales() {
    final route = MaterialPageRoute(
        builder: (BuildContext context) => DatosPersonalesWidget());
    Navigator.push(context, route);
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final route = MaterialPageRoute(
          builder: (BuildContext context) => DatosPersonalesWidget());
      Navigator.push(context, route);
    }
  }

  void _cambiarContrasena() {
    final route = MaterialPageRoute(
        builder: (BuildContext context) => CambiarContrasenaWidget());
    Navigator.push(context, route);
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final route = MaterialPageRoute(
          builder: (BuildContext context) => CambiarContrasenaWidget());
      Navigator.push(context, route);
    }
  }

  void _roles() {
    final route =
        MaterialPageRoute(builder: (BuildContext context) => MisRolesWidget());
    Navigator.push(context, route);
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final route = MaterialPageRoute(
          builder: (BuildContext context) => MisRolesWidget());
      Navigator.push(context, route);
    }
  }

  void _usuarios() {
    final route =
        MaterialPageRoute(builder: (BuildContext context) => UsuariosWidget());
    Navigator.push(context, route);
  }

  void _misHorarios() {
    final route =
        MaterialPageRoute(builder: (BuildContext context) => HorariosWidget());
    Navigator.push(context, route);
  }

  void _cerrarSesion() {
    final route =
        MaterialPageRoute(builder: (BuildContext context) => LoginWidget());
    Navigator.push(context, route);
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final route =
          MaterialPageRoute(builder: (BuildContext context) => LoginWidget());
      Navigator.push(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Column(
            children: [
              ElevatedButton.icon(
                onPressed: _datosPersonales,
                icon: const Icon(Icons.person_pin_outlined),
                label: const Text("Datos Personales"),
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
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _cambiarContrasena,
                icon: const Icon(Icons.password),
                label: const Text("Cambiar contraseña"),
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
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _misHorarios,
                icon: const Icon(Icons.calendar_month),
                label: const Text("Mis Horarios"),
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
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _cerrarSesion,
                icon: const Icon(Icons.sensor_door),
                label: const Text("Cerrar sesión"),
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
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
