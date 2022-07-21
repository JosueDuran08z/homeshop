import 'dart:async';
import 'dart:convert';
import 'package:homeshop/config/Config.dart';
import 'package:homeshop/models/Usuario.dart';
import 'package:http/http.dart' as http;

class LoginRepository {
  Future<http.Response?> login(String email, String contrasenia) async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    Map<String, String> parametros = {
      "email": email,
      "contrasenia": contrasenia
    };
    var body = jsonEncode(parametros);

    String url = "$HOST/login/";
    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    return response;
  }

  Future<http.Response?> registrarse(Usuario usuario, String perfil) async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    Map<String, dynamic> parametros = {
      "email": usuario.email,
      "contrasenia": usuario.contrasenia,
      "calle": usuario.calle,
      "numInterior": usuario.numInterior,
      "numExterior": usuario.numExterior,
      "colonia": usuario.colonia,
      "cp": usuario.cp,
      "telefono": usuario.telefono,
    };

    if (perfil == "particular") {
      Map<String, dynamic> parametrosPersona = {
        "nombre": usuario.persona.nombre,
        "apePaterno": usuario.persona.apePaterno,
        "apeMaterno": usuario.persona.apeMaterno,
        "fechaNacimiento": usuario.persona.fechaNacimientoInsert
      };

      parametros.addAll(parametrosPersona);
    } else {
      Map<String, dynamic> parametrosEmpresa = {
        "razonSocial": usuario.empresa.razonSocial
      };

      parametros.addAll(parametrosEmpresa);
    }

    var body = jsonEncode(parametros);
    String url =
        "$HOST/login/registrar-${perfil == "particular" ? "persona" : "empresa"}";
    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    return response;
  }
}
