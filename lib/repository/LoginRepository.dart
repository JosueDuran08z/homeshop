import 'dart:async';
import 'dart:convert';
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
    String url = "http://localhost:5000/login/";
    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    return response;
  }
}
