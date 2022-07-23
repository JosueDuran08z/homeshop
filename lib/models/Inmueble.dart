import 'dart:typed_data';

import 'package:homeshop/models/Casa.dart';
import 'package:homeshop/models/Departamento.dart';
import 'package:homeshop/models/Edificio.dart';
import 'package:homeshop/models/Terreno.dart';
import 'package:homeshop/models/Usuario.dart';

class Inmueble {
  int? idInmueble, cp, banios;
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
      operacion,
      estatus;
  double? ancho, largo, dimension, precio;
  Usuario usuario = Usuario();
  Casa casa = Casa();
  Departamento departamento = Departamento();
  Edificio edificio = Edificio();
  Terreno terreno = Terreno();
  Uint8List? imagen1Decodificada,
      imagen2Decodificada,
      imagen3Decodificada,
      imagen4Decodificada,
      imagen5Decodificada;

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

  Map<String, dynamic> getMap() {
    return {
      "idInmueble": idInmueble,
      "descripcion": descripcion,
      "calle": calle,
      "numInterior": numInterior,
      "numExterior": numExterior,
      "colonia": colonia,
      "cp": cp,
      "imagen1": imagen1,
      "imagen2": imagen2,
      "imagen3": imagen3,
      "imagen4": imagen4,
      "imagen5": imagen5,
      "banios": banios,
      "ancho": ancho,
      "largo": largo,
      "agua": agua,
      "luz": luz,
      "operacion": operacion,
      "precio": precio,
      "idUsuario": usuario.idUsuario
    };
  }

  Map<String, dynamic> getMapCasa() {
    return {
      "idCasa": casa.idCasa,
      "cochera": casa.cochera,
      "internet": casa.internet,
      "habitaciones": casa.habitaciones,
      "pisos": casa.pisos,
      "edad": casa.edad,
      "estadoInstalaciones": casa.estadoInstalaciones,
    };
  }

  Map<String, dynamic> getMapDepartamento() {
    return {
      "idDepartamento": departamento.idDepartamento,
      "estacionamiento": departamento.estacionamiento,
      "internet": departamento.internet,
      "habitaciones": departamento.habitaciones,
      "pisos": departamento.pisos,
      "edad": departamento.edad,
      "estadoInstalaciones": departamento.estadoInstalaciones,
    };
  }

  Map<String, dynamic> getMapEdificio() {
    return {
      "idEdificio": edificio.idEdificio,
      "estacionamiento": edificio.estacionamiento,
      "internet": edificio.internet,
      "habitaciones": edificio.habitaciones,
      "pisos": edificio.pisos,
      "edad": edificio.edad,
      "estadoInstalaciones": edificio.estadoInstalaciones,
    };
  }

  Map<String, dynamic> getMapTerreno() {
    return {
      "idTerreno": terreno.idTerreno,
      "enConstruccion": terreno.enConstruccion
    };
  }

  Map<String, dynamic> getMapAgregar(String tipo) {
    Map<String, dynamic> inmuebleMap = getMap();
    Map<String, dynamic> tipoMap;

    if (tipo == "casa") {
      tipoMap = getMapCasa();
    } else if (tipo == "departamento") {
      tipoMap = getMapDepartamento();
    } else if (tipo == "edificio") {
      tipoMap = getMapEdificio();
    } else {
      tipoMap = getMapTerreno();
    }

    inmuebleMap.addAll(tipoMap);
    return inmuebleMap;
  }

  Map<String, dynamic> getMapEditar(String tipo) {
    Map<String, dynamic> inmuebleMap = getMap();
    Map<String, Map<String, dynamic>> tipoMap;

    if (tipo == "casa") {
      tipoMap = {"casa": getMapCasa()};
    } else if (tipo == "departamento") {
      tipoMap = {"departamento": getMapDepartamento()};
    } else if (tipo == "edificio") {
      tipoMap = {"edificio": getMapEdificio()};
    } else {
      tipoMap = {"terreno": getMapTerreno()};
    }

    inmuebleMap.addAll(tipoMap);
    return inmuebleMap;
  }
}
