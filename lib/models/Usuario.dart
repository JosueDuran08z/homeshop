import 'package:homeshop/models/Empresa.dart';
import 'package:homeshop/models/Persona.dart';
import 'package:homeshop/models/Rol.dart';

class Usuario {
  int? idUsuario, cp, telefono;
  String? email, contrasenia, calle, numInterior, numExterior, colonia;
  bool? estatus;
  List<Rol> roles = <Rol>[];
  Persona persona = Persona();
  Empresa empresa = Empresa();

  setUsuario(responseData) {
    idUsuario = responseData["idUsuario"];
    email = responseData["email"];
    contrasenia = responseData["contrasenia"];
    calle = responseData["calle"];
    numInterior = responseData["numInterior"];
    numExterior = responseData["numExterior"];
    colonia = responseData["colonia"];
    cp = responseData["cp"];
    telefono = responseData["telefono"];
    estatus = responseData["estatus"];

    if (responseData["persona"] != null) {
      persona.setPersona(responseData["persona"]);
    }

    if (responseData["empresa"] != null) {
      empresa.setEmpresa(responseData["empresa"]);
    }

    if (responseData["roles"] != null) {
      responseData["roles"].forEach((rolData) {
        Rol rol = Rol();
        rol.idRol = rolData["idRol"];
        rol.nombre = rolData["nombre"];
        rol.estatus = rolData["estatus"];
        roles.add(rol);
      });
    }
  }
}
