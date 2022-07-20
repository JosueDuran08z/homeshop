class Dia {
  int? idDia;
  String? nombre;
  bool? estatus;

  setDia(responseData) {
    idDia = responseData["idDia"];
    nombre = responseData["nombre"];
    estatus = responseData["estatus"];
  }
}
