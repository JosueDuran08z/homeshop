import 'package:homeshop/models/Agente.dart';
import 'package:homeshop/models/Usuario.dart';

class Empresa {
  int? idEmpresa;
  String? razonSocial;
  List<Agente> agentes = <Agente>[];

  setEmpresa(responseData) {
    idEmpresa = responseData["idEmpresa"];
    razonSocial = responseData["razonSocial"];
    if (responseData["agentes"] != null) {
      responseData["agentes"].forEach((agenteData) {
        Agente agente = Agente();
        agente.setAgente(agenteData);
        agentes.add(agente);
      });
    }
  }
}
