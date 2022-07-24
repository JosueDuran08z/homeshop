import 'package:homeshop/config/Config.dart';
import 'package:http/http.dart' as http;

class HorarioRepository {
  Future<http.Response?> obtenerTodos() async {
    String url = "$HOST/dia/";
    final response = await http.get(Uri.parse(url));

    return response;
  }
}
