class Usuario {
  int? idUsuario, cp, telefono;
  String? email, contrasenia, calle, numInterior, numExterior, colonia;

  setUsuario(responseData) {
    idUsuario = responseData["idUsuario"];
    email = responseData["email"];
    contrasenia = responseData["contrasenia"];
  }
}
