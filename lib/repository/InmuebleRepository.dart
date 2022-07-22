import 'dart:async';
import 'dart:convert';
import 'package:homeshop/config/Config.dart';
import 'package:homeshop/models/Inmueble.dart';
import 'package:http/http.dart' as http;

class InmuebleRepository {
  Future<http.Response?> obtenerTodos() async {
    String url = "$HOST/inmueble/";
    final response = await http.get(Uri.parse(url));

    return response;
  }

  Future<http.Response?> agregar(Inmueble inmueble, String tipo) async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    Map<String, dynamic> parametros = inmueble.getMapAgregar(tipo);
    var body = jsonEncode(parametros);
    String url = "$HOST/inmueble/agregar-$tipo";
    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    return response;
  }

  Future<http.Response?> cambiarEstatus(
      int idInmueble, String operacion) async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };

    String ruta = "";

    if (operacion == "eliminar")
      ruta = operacion;
    else if (operacion == "activar")
      ruta = operacion;
    else
      ruta = "cambiar-estatus";

    String url = "$HOST/inmueble/$ruta/$idInmueble";
    Map<String, dynamic> parametros = {
      "estatus": operacion == "rentar" ? "Rentado" : "Vendido"
    };
    var body = jsonEncode(parametros);

    final response;

    if (operacion == "vender" || operacion == "rentar") {
      response = await http.post(Uri.parse(url), headers: headers, body: body);
    } else {
      response = await http.post(Uri.parse(url), headers: headers);
    }

    return response;
  }
}
