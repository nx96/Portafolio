import 'package:flutter/material.dart';

//Archivos donde estan las pantallas que quiero mostrar
import 'package:ejemploswidgets/src/page/alert_page.dart';
import 'package:ejemploswidgets/src/page/avatar_page.dart';
import 'package:ejemploswidgets/src/page/home_page.dart';
import 'package:ejemploswidgets/src/page/card_page.dart';
import 'package:ejemploswidgets/src/page/animated_container.dart';
import 'package:ejemploswidgets/src/page/input_page.dart';
import 'package:ejemploswidgets/src/page/slider_page.dart';
import 'package:ejemploswidgets/src/page/listview_page.dart';

Map<String, WidgetBuilder> getRutas() {
  return <String, WidgetBuilder>{
    '/'     : (BuildContext context) => HomePage(),
    'alert' : (BuildContext context) => AlertPage(),
    'avatar': (BuildContext context) => AvatarPage(),
    'card'  : (BuildContext context) => CardPage(),
    'animated': (BuildContext context) => AnimatedContainerPage(),
    'inputs'  : (BuildContext context) => InputPage(),
    'slider'    : (BuildContext context) => SliderPage(),
    'list'    : (BuildContext context) => ListViewPage(),
  };
}
