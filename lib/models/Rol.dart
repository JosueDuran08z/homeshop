import 'package:homeshop/models/Usuario.dart';

class Rol {
  int? idRol;
  String? nombre;
  bool? estatus;
  List<Usuario> usuarios = <Usuario>[];

  setRol(responseData) {
    idRol = responseData["idRol"];
    nombre = responseData["nombre"];
    estatus = responseData["estatus"];

    if (responseData["usuarios"] != null) {
      responseData["usuarios"].forEach((usuarioData) {
        Usuario usuario = Usuario();
        usuario.setUsuario(usuarioData);
      });
    }
  }
}
