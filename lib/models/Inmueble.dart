import 'package:homeshop/models/Casa.dart';
import 'package:homeshop/models/Departamento.dart';
import 'package:homeshop/models/Edificio.dart';
import 'package:homeshop/models/Terreno.dart';
import 'package:homeshop/models/Usuario.dart';

class Inmueble {
  int? idInmueble, cp, banios, estatus;
  bool? agua, luz;
  String? descripcion,
      calle,
      numInterior,
      numExterior,
      colonia,
      imagen1,
      imagen2,
      imagen3,
      imagen4,
      imagen5,
      operacion;
  double? ancho, largo, dimension, precio;
  Usuario usuario = Usuario();
  Casa casa = Casa();
  Departamento departamento = Departamento();
  Edificio edificio = Edificio();
  Terreno terreno = Terreno();

  setInmueble(responseData) {
    idInmueble = responseData["idInmueble"];
    descripcion = responseData["descripcion"];
    calle = responseData["calle"];
    numInterior = responseData["numInterior"];
    numExterior = responseData["numExterior"];
    colonia = responseData["colonia"];
    cp = responseData["cp"];
    imagen1 = responseData["imagen1"];
    imagen2 = responseData["imagen2"];
    imagen3 = responseData["imagen3"];
    imagen4 = responseData["imagen4"];
    imagen5 = responseData["imagen5"];
    banios = responseData["banios"];
    ancho = responseData["ancho"];
    largo = responseData["largo"];
    dimension = responseData["dimension"];
    agua = responseData["agua"];
    luz = responseData["luz"];
    operacion = responseData["operacion"];
    precio = responseData["precio"];
    estatus = responseData["estatus"];
    usuario.setUsuario(responseData["usuario"]);

    if (responseData["casa"] != null) casa.setCasa(responseData["casa"]);

    if (responseData["departamento"] != null) {
      departamento.setDepartamento(responseData["departamento"]);
    }

    if (responseData["edificio"] != null) {
      edificio.setEdificio(responseData["edificio"]);
    }

    if (responseData["terreno"] != null) {
      terreno.setTerreno(responseData["terreno"]);
    }
  }
}
