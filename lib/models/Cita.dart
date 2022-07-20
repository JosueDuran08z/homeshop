import 'package:homeshop/models/Inmueble.dart';
import 'package:homeshop/models/Usuario.dart';

class Cita {
  int? idCita, duracion;
  DateTime? horaInicio, horaFin;
  bool? estatus;
  Usuario cliente = Usuario();
  Usuario propietario = Usuario();
  Inmueble inmueble = Inmueble();

  setCita(responseData) {
    idCita = responseData["idCita"];
    horaInicio = responseData["horaInicio"];
    horaFin = responseData["horaFin"];
    duracion = responseData["duracion"];
    estatus = responseData["estatus"];
    cliente.setUsuario(responseData["cliente"]);
    propietario.setUsuario(responseData["propietario"]);
    inmueble.setInmueble(responseData["inmueble"]);
  }
}
