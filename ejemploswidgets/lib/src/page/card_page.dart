import 'package:flutter/material.dart';

class CardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tarjetas"),
        ),
        body: ListView(
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            _crearTarjeta1(),
          Divider(),
           _crearTarjeta2(),
           Divider(),
            _crearTarjeta1(),
          Divider(),
           _crearTarjeta2(),
           Divider(),
            _crearTarjeta1(),
          Divider(),
           _crearTarjeta2(),
           Divider(),
            _crearTarjeta1(),
          Divider(),
           _crearTarjeta2(),
           Divider(),
            _crearTarjeta1(),
          Divider(),
           _crearTarjeta2(),
           Divider(),
            _crearTarjeta1(),
          Divider(),
           _crearTarjeta2(),
           Divider(),
            _crearTarjeta1(),
          Divider(),
           _crearTarjeta2(),
           Divider(),
            _crearTarjeta1(),
          Divider(),
           _crearTarjeta2(),
           Divider(),
            _crearTarjeta1(),
          Divider(),
           _crearTarjeta2(),
           Divider(),
            _crearTarjeta1(),
          Divider(),
           _crearTarjeta2(),
           Divider(),
            _crearTarjeta1(),
          Divider(),
           _crearTarjeta2(),
           Divider(),
           ],
        ));
  }

  Widget _crearTarjeta1() {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.remove_red_eye,
              color: Colors.pink,
            ),
            title: Text("Titulo"),
            subtitle: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                onPressed: () {},
                child: Text("Cancelar"),
              ),
              FlatButton(
                onPressed: () {},
                child: Text("Aceptar"),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _crearTarjeta2() {
    final card = Container(
      child: Column(
        children: <Widget>[

          FadeInImage(
            image: NetworkImage('https://ugc-about.futurelearn.com/wp-content/uploads/Become-a-leader.jpg'),
            placeholder: AssetImage('assets/jar_loading.gif'),
            fadeInDuration: Duration(milliseconds: 200),
            height: 250.0,
            fit: BoxFit.cover,
            ),

          Container(
            padding: EdgeInsets.all(10.0),
            child: Text('What is Lorem Ipsum?'),
          )


        ],
      ),
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black38,
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 10.0))
        ]
      ),

      child: ClipRRect(borderRadius: BorderRadius.circular(10.0),
      child: card,),
      );
  }
}
