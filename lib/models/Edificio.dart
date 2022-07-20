class Edificio {
  int? idEficio, habitaciones, pisos, edad;
  bool? estacionamiento, internet;
  String? estadoInstalaciones;

  setEdificio(responseData) {
    idEficio = responseData["idEficio"];
    habitaciones = responseData["habitaciones"];
    pisos = responseData["pisos"];
    edad = responseData["edad"];
    estacionamiento = responseData["estacionamiento"];
    internet = responseData["internet"];
    estadoInstalaciones = responseData["estadoInstalaciones"];
  }
}
