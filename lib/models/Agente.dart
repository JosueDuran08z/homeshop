import 'package:homeshop/models/Empresa.dart';
import 'package:homeshop/models/Persona.dart';

class Agente {
  int? idAgente;

  setAgente(responseData) => idAgente = responseData["idAgente"];
}
