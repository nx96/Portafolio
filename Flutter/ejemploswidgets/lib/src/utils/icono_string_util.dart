import 'package:flutter/material.dart';

final _icons = <String, IconData>{
  'add_alert'     : Icons.add_alert,
  'accessibility' : Icons.accessibility,
  'folder_open'   : Icons.folder_open,
  'brightness_6'  : Icons.brightness_6,
  'input'         : Icons.input,
  'tune'          : Icons.tune,
  'list'          : Icons.list,
};


Icon getIcon (String nombreIcono) {

    return Icon( _icons[nombreIcono], color: Colors.blue,);

}