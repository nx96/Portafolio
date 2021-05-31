import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  InputPage({Key key}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String _cadena = "";
  String _cadenaEmail = "";
  String _fecha = "";
  TextEditingController _inputFieldDateController = new TextEditingController();
  String _opcionSeleccionada = 'Fuerza';
  List<String> _poderes = [
    'Fuerza',
    'Volar',
    'Rayos X',
    'Super velocidad',
    'Resistencia al agua',
    'Oido agudo',
    'No es Clark Ken',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ejemplos de Inputs"),
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          _crearInput(),
          Divider(),
          _crearInputEmail(),
          Divider(),
          _crearInputPass(),
          Divider(),
          _crearInputDate(context),
          Divider(),
          _crearDropDown(),
          Divider(),
          _crearTexto(),
          Divider(),
          _crearTarjeta1(),
          //_crearTexto(),
        ],
      ),
    );
  }

  Widget _crearInput() {
    return TextField(
      textCapitalization: TextCapitalization.characters,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          counter: Text("Letras ${_cadena.length} "),
          labelText: "Texto Superior",
          suffixText: "Texto final",
          suffixIcon: Icon(Icons.arrow_left),
          helperText: "Texto inferior",
          hintText: "Texto base",
          icon: Icon(Icons.insert_emoticon)),
      onChanged: (valor) {
        setState(() {
          _cadena = valor;
        });
      },
    );
  }

  Widget _crearInputEmail() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          suffixIcon: Icon(Icons.alternate_email),
          labelText: "Email",
          hintText: "Email",
          icon: Icon(Icons.email)),
      onChanged: (valor) {
        setState(() {
          _cadenaEmail = valor;
        });
      },
    );
  }

  Widget _crearInputPass() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          suffixIcon: Icon(Icons.security),
          labelText: "Password",
          hintText: "Password",
          icon: Icon(Icons.screen_lock_portrait)),
      onChanged: (valor) {
        setState(() {});
      },
    );
  }

  Widget _crearInputDate(BuildContext context) {
    return TextField(
      controller: _inputFieldDateController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          suffixIcon: Icon(Icons.calendar_view_day),
          labelText: "Fecha de nacimiento",
          hintText: "Fecha",
          icon: Icon(Icons.calendar_today)),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selecionarFecha(context);
      },
    );
  }

  _selecionarFecha(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2018),
      lastDate: new DateTime(2020),
      locale: Locale('es', 'ES'),
    );

    if (picked != null) {
      _fecha = picked.year.toString() +
          "-" +
          picked.month.toString() +
          "-" +
          picked.day.toString();
      _inputFieldDateController.text = _fecha;
    }
  }

  List<DropdownMenuItem<String>> getOpcions() {
    List<DropdownMenuItem<String>> lista = new List();
    _poderes.forEach((poder) {
      lista.add(DropdownMenuItem(
        child: Text(poder),
        value: poder,
      ));
    });
    return lista;
  }

  Widget _crearDropDown() {
    return Row(
      children: <Widget>[
        Icon(Icons.all_inclusive),
        SizedBox(
          width: 15.0,
        ),
        Expanded(
          child: Container(
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            child: DropdownButton(
              icon: Icon(Icons.arrow_drop_down),
              value: _opcionSeleccionada,
              items: getOpcions(),
              onChanged: (opt) {
                setState(() {
                  _opcionSeleccionada = opt;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _crearTexto() {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text("Nombre: $_cadena (${_cadena.length})"),
        ),
        ListTile(
          title: Text("Email: $_cadenaEmail"),
        ),
        ListTile(
          title: Text("Fecha: $_fecha"),
        ),
        ListTile(
          title: Text("Poder: $_opcionSeleccionada"),
        ),
      ],
    );
  }

  Widget _crearTarjeta1() {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.perm_contact_calendar,
              color: Colors.pink,
            ),
            title: Text("$_cadena"),
            subtitle: Text("$_cadenaEmail\n$_fecha\n$_opcionSeleccionada"),
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
}
