import 'package:flutter/material.dart';
import 'package:homeshop/widgets/cuenta/cambiarContrase%C3%B1aWidget.dart';
import 'package:homeshop/widgets/cuenta/datosPersonaleWidget.dart';
import 'package:homeshop/widgets/login/loginWidget.dart';

class MiCuentaWidget extends StatefulWidget {
  MiCuentaWidget({Key? key}) : super(key: key);

  @override
  State<MiCuentaWidget> createState() => _MiCuentaWidgetState();
}

class _MiCuentaWidgetState extends State<MiCuentaWidget> {
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

  void _cerrarSesion() {
    final route = MaterialPageRoute(
        builder: (BuildContext context) => LoginWidget());
    Navigator.push(context, route);
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final route = MaterialPageRoute(
          builder: (BuildContext context) => LoginWidget());
      Navigator.push(context, route);
    }
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
                "Gestionar Cuenta",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[600],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
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
          ),
        ),
      ],
    );
  }
}