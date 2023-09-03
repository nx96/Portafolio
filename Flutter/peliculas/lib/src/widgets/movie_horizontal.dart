import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  //const MovieHorizontal({Key key}) : super(key: key);

  final _pageController = PageController(
    initialPage: 1,
    //Es la cantidad de "espacio" que ocuparian las tarjetas
    //0.5 * 2 = 1 Donde 1 es la pantalla y se veran dos tarjetas
    //0.3 * 3 = 0.9 Donde 0.9 (casi 1) es la pantalla y se veran tres tarjetas
    viewportFraction: 0.33,
  );
  final List<Pelicula> peliculas;
  //Function siguientePagina();

  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  @override
  Widget build(BuildContext context) {
    final _screensize = MediaQuery.of(context).size;

    _pageController.addListener((){
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200){
        //print("AQUI nuevas paginas");
        siguientePagina();
      }
    });

    return Container(
      height: _screensize.height * 0.3,
      child: PageView.builder(
        controller: _pageController,
        pageSnapping: false,
        itemCount: peliculas.length,
        itemBuilder: (BuildContext context, int i){
          return _tarjeta(context, peliculas[i]);
        },
        //children: _tarjetas(context),
      ),
    );
  }

  Widget _tarjeta (BuildContext context, Pelicula pelicula){

            final tarjeta = Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              //Para añadir borde circular
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                //Para cubrir el maximo de pantalla
                fit: BoxFit.cover,
                height: 150.0,
              ),
            ),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      );

      return GestureDetector(
        child: tarjeta,
        onTap: (){
          Navigator.pushNamed(context, 'detalle', arguments: pelicula);
        },
      );
    
  }

  List<Widget> _tarjetas(BuildContext context) {
    return peliculas.map((pelicula) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              //Para añadir borde circular
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                //Para cubrir el maximo de pantalla
                fit: BoxFit.cover,
                height: 150.0,
              ),
            ),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      );
    }).toList();
  }
}
