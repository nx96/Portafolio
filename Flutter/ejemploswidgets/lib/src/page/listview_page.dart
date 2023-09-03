import 'package:flutter/material.dart';

import 'dart:math';

import 'dart:async';

class ListViewPage extends StatefulWidget {
  ListViewPage({Key key}) : super(key: key);

  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  ScrollController _scrollController = new ScrollController();
  Random random = new Random();
  List<int> _listaNumero = new List(); // = [15,24,37,48,56,8];
  int _ultimoNumero = 0;
  bool _isLoading = false;
  //var _listaNumero = [random.nextInt(100),2,3,4,56,8];

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  void initState() {
    super.initState();

    agregar10();

    _scrollController.addListener(() {
      //print("Scroll");
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //agregar10();
        fetchData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List View"),
      ),
      body: Stack(
        children: <Widget>[
          _crearListView(),
          _crearLoading(),
        ],
      ),
    );
  }

  Widget _crearListView() {
    return RefreshIndicator(
      onRefresh: obtenerPagina,
      
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _listaNumero.length,
        itemBuilder: (BuildContext context, int index) {
          final imagen = _listaNumero[index];

          print("HERE");
          return FadeInImage(
            placeholder: AssetImage('assets/jar_loading.gif'),
            image: NetworkImage(
                'https://picsum.photos/id/1/500/300/?image=$imagen'),
          );
        },
      ),
    );
  }

  Future obtenerPagina() async {
    final duration = Duration(seconds: 2);
    new Timer(duration, () {
      _listaNumero.clear();
      _ultimoNumero++;
      agregar10();
    });
    return Future.delayed(duration);
  }

  void agregar10() {
    for (var i = 0; i < 10; i++) {
      _ultimoNumero++; // = random.nextInt(200);
      _listaNumero.add(_ultimoNumero);
    }

    setState(() {});
  }

  Future fetchData() async {
    _isLoading = true;
    setState(() {});

    final duration = Duration(seconds: 2);
    return new Timer(duration, respuestaHTTP);
  }

  void respuestaHTTP() {
    _isLoading = false;

    _scrollController.animateTo(_scrollController.position.pixels + 100,
        curve: Curves.decelerate, duration: Duration(milliseconds: 200));
    agregar10();
  }

  Widget _crearLoading() {
    if (_isLoading) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[CircularProgressIndicator()],
          ),
          SizedBox(
            height: 15.0,
          )
        ],
      );
    } else {
      return Container();
    }
  }
}
