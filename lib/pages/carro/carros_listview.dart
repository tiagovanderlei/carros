import 'package:carros/pages/carro/carro_detalhe.dart';
import 'package:carros/pages/carro/carros_bloc.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';

import 'carro.dart';
import 'carros_api.dart';

class CarrosListView extends StatefulWidget {
  TiposCarro tipo;

  CarrosListView({@required this.tipo});

  @override
  _CarrosListViewState createState() => _CarrosListViewState();
}

class _CarrosListViewState extends State<CarrosListView>
    with AutomaticKeepAliveClientMixin<CarrosListView> {
  List<Carro> carros;
  final _bloc = CarrosBloc();

  TiposCarro get tipo => this.widget.tipo;

  @override
  void initState() {
    _bloc.fetch(tipo);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    print('>> ListView');

    return StreamBuilder<List<Carro>>(
      stream: _bloc.stream,
      builder: (BuildContext context, AsyncSnapshot<List<Carro>> snapshot) {
        if (snapshot.hasError) {
          return TextError(
            msg: 'Não foi possível buscar os carros',
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Carro> carros = snapshot.data;
        return _listView(carros);
      },
    );
  }

  Container _listView(List<Carro> carros) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
          itemCount: carros != null ? carros.length : 0,
          itemBuilder: (context, index) {
            Carro carro = carros[index];

            return Card(
              color: Colors.grey[100],
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                        child: Image.network(
                      carro.urlFoto ??
                          'https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/esportivos/Ferrari_FF.png',
                      width: 250,
                    )),
                    carro.nome != null
                        ? Text(
                            carro.nome,
                            style: TextStyle(fontSize: 25),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        : Text(
                            '<< sem nome >>',
                            style: TextStyle(fontSize: 25, color: Colors.red),
                          ),
                    carro.descricao != null
                        ? Text(
                            carro.descricao,
                            style: TextStyle(fontSize: 16),
                          )
                        : Text(
                            '<< sem descricao >>',
                            style: TextStyle(fontSize: 25, color: Colors.red),
                          ),
                    ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('DETALHES'),
                          onPressed: () {
                            push(context, CarroDetalhe(carro));
                          },
                        ),
                        FlatButton(
                          child: const Text('SHARE'),
                          onPressed: () {/* ... */},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
