import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:mobx/mobx.dart';

part 'carros_model.g.dart';

class CarrosModel = CarrosModelBase with _$CarrosModel;

abstract class CarrosModelBase with Store{

  @observable
  List<Carro> carros;

  @observable
  Object error;

  @action
  fetch(TiposCarro tipo) async {
    try {
      error = null;
      carros = await CarrosApi.getCarros(tipo: tipo);
    } catch(e, s){
      error = e;
    }
  }
}