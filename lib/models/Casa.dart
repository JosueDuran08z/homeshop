import 'package:homeshop/models/Inmueble.dart';

class Casa {
  int? idCasa, habitaciones, pisos, edad;
  bool? cochera, internet;
  String? estadoInstalaciones;

  setCasa(responseData) {
    idCasa = responseData["idCasa"];
    habitaciones = responseData["habitaciones"];
    pisos = responseData["pisos"];
    edad = responseData["edad"];
    cochera = responseData["cochera"];
    internet = responseData["internet"];
    estadoInstalaciones = responseData["estadoInstalaciones"];
  }
}
