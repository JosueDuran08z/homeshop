import 'package:flutter/material.dart';
import 'package:homeshop/models/Dia.dart';
import 'package:homeshop/models/Persona.dart';
import 'package:intl/intl.dart';

class Horario {
  int? idHorario, duracion;
  DateTime? horaInicio, horaFin;
  bool? estatus;
  List<Dia> dias = <Dia>[];
  Persona persona = Persona();
  DateTime hoy = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  String? diasString;

  setHorario(responseData) {
    diasString = "";
    String fecha = formatter.format(hoy);
    idHorario = responseData["idHorario"];
    horaInicio = DateTime.parse("$fecha ${responseData["horaInicio"]}");
    horaFin = DateTime.parse("$fecha ${responseData["horaFin"]}");
    duracion = responseData["duracion"];
    estatus = responseData["estatus"];
    persona.setPersona(responseData["persona"]);

    responseData["dias"].forEach((diaData) {
      Dia dia = Dia();
      dia.setDia(diaData);
      dias.add(dia);
    });

    if (dias.length == 1) {
      diasString = dias[0].nombre;
    } else if (dias.length == 2) {
      diasString = "${dias[0].nombre!} y ${dias[1].nombre!}";
    } else {
      for (int i = 0; i < dias.length; i++) {
        if (i + 1 < dias.length) {
          diasString = "${diasString!}${dias[i].nombre!}, ";
        } else {
          diasString = "${diasString!}y ${dias[i].nombre!}";
        }
      }
    }
  }
}
