import 'dart:async';
import 'dart:convert';

import 'package:peliculas/env.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;


class PeliculasProvider{
  String _apikey   = API_MOVIE;
  String _url      = 'api.themoviedb.org';
  //Path sin argumentos (Es decir al sitio al cual accedo y luego solicito datos)
  String _pathEnCines      = '3/movie/now_playing';
  String _pathPopulares      = '3/movie/popular';
  String _language = 'es-ES';

  int _popularesPage = 0;
  bool _cargandoPeliculas = false;
  List<Pelicula> _populares = new List();
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams(){
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, _pathEnCines , {
      'api_key'  : _apikey,
      'language' : _language
      });

      final resp = await http.get(url);
      final decodeData = json.decode(resp.body);

      final peliculas = new Peliculas.fromJsonList(decodeData['results']);
      return peliculas.items; 

  }

  Future<List<Pelicula>> getPopulares() async {

    if(_cargandoPeliculas) return[];

    _cargandoPeliculas = true;
    _popularesPage++;

    final url = Uri.https(_url, _pathPopulares , {
      'api_key'  : _apikey,
      'language' : _language,
      'page'     : _popularesPage.toString(),      
      });


      final resp = await http.get(url);
      final decodeData = json.decode(resp.body);

      final peliculas = new Peliculas.fromJsonList(decodeData['results']);
      
      //Proceso de Stream
      _populares.addAll(peliculas.items);
      popularesSink(_populares);
      //Fin proceso de Stream

      _cargandoPeliculas = false;
      return peliculas.items; 

  }

}