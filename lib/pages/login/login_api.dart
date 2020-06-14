import 'dart:convert';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/pages/login/usuario_sessao.dart';
import 'package:carros/utils/prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LoginApi {
  static Future<ApiResponse<Usuario>> login (
      {String login, String senha}) async {
    try {
      String url = 'http://carros-springboot.herokuapp.com/api/v2/login';

      Map<String, String> params = {"username": login, "password": senha};

      Map<String, String> headers = {"Content-Type": "application/json"};

      String s = json.encode(params);

      var response = await http.post(url, body: s, headers: headers);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

//    if (response.statusCode == 200) {
      Map mapResponse = json.decode(response.body);

      print('Nome: ${mapResponse["nome"]}');
      print('Email: ${mapResponse["email"]}');

      if (response.statusCode == 200) {
        final Usuario usuario = Usuario.fromJson(mapResponse);

        UsuarioSessao.setDadosUsuario(usuario: usuario);

        return ApiResponse<Usuario>.ok(result: usuario);
      } else {
        return ApiResponse<Usuario>.error(msg: mapResponse["error"]);
      }
//    } else {
//      return false;
//    }
    } catch (error, exception) {
      print('Erro no login $error > $exception');
      return ApiResponse<Usuario>.error(msg: 'Não foi possível fazer o login!');
    }
  }
}