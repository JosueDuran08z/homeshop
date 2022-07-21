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
}
