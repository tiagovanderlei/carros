import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:flutter/material.dart';

class CarroDetalhe extends StatelessWidget {
  Carro _carro;
  CarroDetalhe(this._carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carro'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.place),
            onPressed: _onPressedMap,
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: _onPressedVideo,
          ),
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text('Editar'),
                  value: 'Editar',
                ),
              ];
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Image.network(this._carro.urlFoto),
      ),
    );
  }

  void _onPressedMap() {}

  void _onPressedVideo() {}
}