import 'package:flutter/material.dart';

class HomePageTemp extends StatelessWidget {
  
  final opciones = ["Uno", "Dos", "Tres", "Cuatro", "Cinco", "Seis", "Siete", "Ocho", "Nueve", "Diez"];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Titulo"),),
      body: ListView(children: _crearObjetosCorta()),
    );
  }

  List<Widget> _crearObjetos (){

    List<Widget> lista = new List<Widget>();

    for (var opcion in opciones) {

      final tempWidget = ListTile(title: Text(opcion),);

      lista..add(tempWidget)..add(Divider());
      
    }
    return lista;
  }

  List<Widget> _crearObjetosCorta (){

    var widget = opciones.map( (item) {
      
      return Column(
        children: <Widget>[
          ListTile(
            title: Text(item + '!'),
            subtitle: Text("Este texto pertenece a "+item),
            leading: Icon(Icons.airplay),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: (){},
            ),
          //Divider(),
        ],
      );

    }).toList();

    return widget;
  }


}