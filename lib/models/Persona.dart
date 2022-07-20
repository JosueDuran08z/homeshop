class Persona {
  int? idPersona;
  String? nombre, apePaterno, apeMaterno;
  DateTime? fechaNacimiento;

  setPersona(responseData) {
    idPersona = responseData["idPersona"];
    nombre = responseData["nombre"];
    apePaterno = responseData["apePaterno"];
    apeMaterno = responseData["apeMaterno"];
    fechaNacimiento = DateTime.parse(responseData["fechaNacimiento"]);
  }
}
