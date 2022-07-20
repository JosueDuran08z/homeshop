import 'package:homeshop/models/Dia.dart';
import 'package:homeshop/models/Persona.dart';

class Horario {
  int? idHorario, duracion;
  DateTime? horaInicio, horaFin;
  bool? estatus;
  List<Dia> dias = <Dia>[];
  Persona persona = Persona();

  setHorario(responseData) {
    idHorario = responseData["idHorario"];
    horaInicio = responseData["horaInicio"];
    horaFin = responseData["horaFin"];
    duracion = responseData["duracion"];
    estatus = responseData["estatus"];
    persona.setPersona(responseData["persona"]);

    responseData["dias"].forEach((diaData) {
      Dia dia = Dia();
      dia.setDia(diaData);
      dias.add(dia);
    });
  }
}
