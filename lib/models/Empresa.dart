import 'package:homeshop/models/Usuario.dart';

class Empresa {
  int? idEmpresa;
  String? razonSocial;

  setEmpresa(responseData) {
    idEmpresa = responseData["idEmpresa"];
    razonSocial = responseData["razonSocial"];
  }
}
