class Edificio {
  int? idEdificio, habitaciones, pisos, edad;
  bool? estacionamiento, internet;
  String? estadoInstalaciones;

  setEdificio(responseData) {
    idEdificio = responseData["idEdificio"];
    habitaciones = responseData["habitaciones"];
    pisos = responseData["pisos"];
    edad = responseData["edad"];
    estacionamiento = responseData["estacionamiento"];
    internet = responseData["internet"];
    estadoInstalaciones = responseData["estadoInstalaciones"];
  }
}
