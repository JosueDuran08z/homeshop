class Terreno {
  int? idTerreno;
  bool? enConstruccion;

  setTerreno(responseData) {
    idTerreno = responseData["idTerreno"];
    enConstruccion = responseData["enConstruccion"];
  }
}
