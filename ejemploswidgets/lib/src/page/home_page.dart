//import 'package:ejemploswidgets/src/page/avatar_page.dart';
import 'package:ejemploswidgets/src/providers/menu_provider.dart';
import 'package:ejemploswidgets/src/utils/icono_string_util.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nuevo Titulo"),
      ),
      body: _lista(),
    );
  }

  Widget _lista() {

    return FutureBuilder(
      initialData: [] ,
      future: menuProvider.cargarData(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        return ListView(
          children: _listaItems(snapshot.data, context),
          );
      },
    );



  }

  List<Widget> _listaItems( List<dynamic> data, BuildContext context){

    final List<Widget> opciones = [];

    //if ( data == null){return []}

    data.forEach( (opt) {

      final widgetTemp = ListTile(
        title: Text( opt['texto'],),         
        leading: getIcon(opt['icon']),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.pink,),
        onTap: (){
          //Hay dos formas de saltar de una pagina a otra
          //La primera es asignando la clase a la que va a saltar 
          /*
          final ruta = MaterialPageRoute(builder: (context) => AvatarPage());
          Navigator.push(context, ruta);
          */

          //La segunda es escribiendo el String de la ruta y manejando una lista con todas las posibles rutas
          Navigator.pushNamed(context, opt['ruta']);
        },
        );
      
      opciones.add(widgetTemp);
      });

    return opciones;

  }
}
