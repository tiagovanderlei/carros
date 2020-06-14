import 'dart:convert';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/pages/login/usuario_sessao.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

enum TiposCarro{
  classicos,
  esportivos,
  luxo
}

class CarrosApi{
  static Future<List<Carro>> getCarros({@required TiposCarro tipo}) async{
    List<Carro> carros;
//    await Future.delayed(Duration(seconds: 2));
//
//    carros.add(Carro(nome: 'Ferrari FF', urlFoto: 'https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/esportivos/Ferrari_FF.png'));
//    carros.add(Carro(nome: 'AUDI GT Spyder', urlFoto: 'https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/esportivos/Audi_Spyder.png'));
//    carros.add(Carro(nome: 'Porsche Panamera', urlFoto: 'https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/esportivos/Porsche_Panamera.png'));

    try {

      final String tipoCarro = tipo.toString().split('.').last;
      String url = 'http://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipoCarro';

      Usuario usuario = await UsuarioSessao.getDadosUsuario();

      Map<String, String> headers = {
        "Content-Type":"application/json",
        "Authorization":"Bearer ${usuario.token}"
      };

      print('GET url: $url');

      var response = await http.get(url, headers: headers);

      List listaCarros = json.decode(response.body);

      carros = listaCarros.map<Carro>((map) => Carro.fromJson(map)).toList();


    } catch(error, exception) {
      print('$error >> $exception');
      throw exception;
    }

    return carros;
  }
}