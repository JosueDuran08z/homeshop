class Departamento {
  int? idDepartamento, habitaciones, pisos, edad;
  bool? estacionamiento, internet;
  String? estadoInstalaciones;

  setDepartamento(responseData) {
    idDepartamento = responseData["idDepartamento"];
    habitaciones = responseData["habitaciones"];
    pisos = responseData["pisos"];
    edad = responseData["edad"];
    estacionamiento = responseData["estacionamiento"];
    internet = responseData["internet"];
    estadoInstalaciones = responseData["estadoInstalaciones"];
  }
}
