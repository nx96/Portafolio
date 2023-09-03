import 'dart:convert';

import 'package:flutter/services.dart';
//import 'package:flutter/widgets.dart';

class _MenuProvider {
  List<dynamic> opciones = [];

  _MenuProvider() {
    //cargarData();
  }

  Future <List<dynamic>> cargarData() async {

    final resp = await rootBundle.loadString('data/menu_opts.json');

    Map dataMap = json.decode(resp);
    print(dataMap['rutas']);
    // rutas se refiere a la etiqueta que contiene el json
    opciones = dataMap['rutas'];

    return opciones; 

  }
}


final menuProvider = new _MenuProvider();