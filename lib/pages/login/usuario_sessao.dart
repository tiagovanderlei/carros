import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/prefs.dart';
import 'dart:convert' as convert;

import 'package:flutter/material.dart';

class UsuarioSessao{
  static Future<Usuario> getDadosUsuario() async {
    String json = await Prefs.getString('user.prefs');
    if (json.isEmpty)
      return null;
    Map<String, dynamic> map = convert.json.decode(json);

    return Usuario.fromJson(map);
  }

  static void setDadosUsuario({@required Usuario usuario}){
    Map<String, dynamic> map = usuario.toJson();
    String json = convert.json.encode(map);
    Prefs.setString('user.prefs', json);
  }

  static void clearDadosUsuario() {
    Prefs.setString('user.prefs', null);
  }
}