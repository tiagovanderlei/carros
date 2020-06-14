
import 'dart:async';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/pages/simple_bloc.dart';

class CarrosBloc extends SimpleBloc<List<Carro>>{

  void fetch(TiposCarro tipo) async {
    try {
      List<Carro> carros = await CarrosApi.getCarros(tipo: tipo);
      add(carros);
    } catch(e, s){
      addError(e);
    }
  }
}