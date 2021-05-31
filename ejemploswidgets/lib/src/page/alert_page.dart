import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alert Page"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Boton"),
          onPressed: () => _crearDialogo(context),
          color: Colors.black,
          textColor: Colors.white,
          elevation: 10.0,
          shape: StadiumBorder(),
        ),
      ),
    );
  }

  void _crearDialogo(BuildContext context) {
    showDialog(        
        context: context,        
        barrierDismissible: true,
        builder: (context) {          
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            title: Text('Titulo'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Cuerpo del mensaje que deberia ser mas extenso para hacer mas pruebas"), 
                FlutterLogo(size: 100.0,)],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text("Cancelar"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        });
  }
}
