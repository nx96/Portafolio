import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_providers.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';
import 'package:toast/toast.dart';

class HomePage extends StatelessWidget {
  //const HomePage({Key key}) : super(key: key);

  final peliculasProvedir = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvedir.getPopulares();
    return Scaffold(
      appBar: AppBar(
        title: Text("Peliculas"),
        backgroundColor: Colors.deepPurpleAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => Toast.show("Buscador de peliculas", context, gravity: Toast.CENTER, duration: Toast.LENGTH_SHORT)),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _crearSwiper(),
            _crearFooter(context),
          ],
        ),
      ),
      /*
      SafeArea(
        child: Text("HEY NX"),
      ),
      */
    );
  }

  Widget _crearSwiper() {
    return FutureBuilder(
      future: peliculasProvedir.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(
            peliculas: snapshot.data,
          );
        } else {
          return Container(
            height: 350.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _crearFooter(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                'Populares',
                style: Theme.of(context).textTheme.subhead,
              )),
          SizedBox(
            height: 5.0,
          ),
          StreamBuilder(
            stream: peliculasProvedir.popularesStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  //se debe llamar a la funcion, pero sin utilizar los parentesis
                  //pues es solo una referencia
                  siguientePagina: peliculasProvedir.getPopulares,
                  peliculas: snapshot.data,
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }



}