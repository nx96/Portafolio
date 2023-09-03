import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double _expansion = 0.0;
  double _red = 0.0;
  double _green = 0.0;
  double _blue = 0.0;
  double _height = 5.0;
  double _width = 5.0;
  bool _bloquearSlider = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Slider"),
      ),
      body: Column(
        children: <Widget>[
          Divider(),
          _crearSlider(),
          _crearCheckBox(),
          _crearSwitch(),
          Expanded(
            child: _crearImagen(),
          ),
          //Divider(),
          //_crearSlider2()
        ],
      ),
    );
  }

  Widget _crearSlider() {
    return Slider(
      min: 0.0,
      max: 400.0,
      value: _expansion,
      activeColor: Colors.indigoAccent,
      label: "Tamaño imagen",
      onChanged: (_bloquearSlider)
          ? null
          : (value) {
              setState(() {
                _expansion = value;
              });
            },
    );
  }

  Widget _crearImagen() {
    return Image(
      image: NetworkImage(
          'https://cdn.pixabay.com/photo/2018/06/27/12/55/artificial-neural-network-3501528_960_720.png'),
      width: _expansion,
      fit: BoxFit.contain,
    );
  }

  Widget _crearSlider2() {
    return Column(
      children: <Widget>[
        Slider(
          min: 0.0,
          max: 255.0,
          value: _red,
          activeColor: Colors.red,
          onChanged: (value) {
            setState(() {
              _red = value;
            });
          },
        ),
        Slider(
          min: 0.0,
          max: 255.0,
          value: _green,
          activeColor: Colors.greenAccent,
          onChanged: (value) {
            setState(() {
              _green = value;
            });
          },
        ),
        Slider(
          min: 0.0,
          max: 255.0,
          value: _blue,
          activeColor: Colors.blue,
          onChanged: (value) {
            setState(() {
              _blue = value;
            });
          },
        ),
        Slider(
          min: 0.0,
          max: 200.0,
          value: _height,
          activeColor: Colors.black,
          onChanged: (value) {
            setState(() {
              _height = value;
            });
          },
        ),
        Slider(
          min: 0.0,
          max: 200.0,
          value: _width,
          activeColor: Colors.black,
          onChanged: (value) {
            setState(() {
              _width = value;
            });
          },
        ),
        AnimatedContainer(
          duration: Duration(seconds: 1),
          height: _height,
          width: _width,
          color: Color.fromRGBO(_red.toInt(), _green.toInt(), _blue.toInt(), 1),
        ),
      ],
    );
  }

  Widget _crearCheckBox() {
    return CheckboxListTile(
      title: Text("CheckBox"),
      value: _bloquearSlider,
      onChanged: (valor) {
        setState(() {
          _bloquearSlider = valor;
        });
      },
    );
  }

  Widget _crearSwitch() {
    return SwitchListTile(
      title: Text("SwitchTitle"),
      value: _bloquearSlider,
      onChanged: (valor) {
        setState(() {
          _bloquearSlider = valor;
        });
      },
    );
  }
}
