import 'package:homeshop/config/Config.dart';
import 'package:http/http.dart' as http;

class HorarioRepository {
  Future<http.Response?> obtenerTodosPorUsuarioId(int idUsuario) async {
    String url = "$HOST/horario/usuario/$idUsuario";
    final response = await http.get(Uri.parse(url));

    return response;
  }

  Future<http.Response?> cambiarEstatus(int idHorario, bool eliminar) async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    String url =
        "$HOST/horario/${eliminar ? "eliminar" : "activar"}/$idHorario";
    final response = await http.post(Uri.parse(url), headers: headers);

    return response;
  }
}
