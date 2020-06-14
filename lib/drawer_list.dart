import 'package:carros/pages/login/login_page.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/pages/login/usuario_sessao.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<Usuario> future = UsuarioSessao.getDadosUsuario();

    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            FutureBuilder(
              future: future,
              builder: (BuildContext context, AsyncSnapshot<Usuario> snapshot) {

                Usuario usuario = snapshot.data;

                if (usuario != null) {
                  return _drawerHeader(
                    nome: usuario.nome,
                    email: usuario.email,
                    urlFoto: usuario.urlFoto,
                  );


                } else {
                  return _drawerHeader(
                    nome: 'usuario',
                    email: 'email',
                    urlFoto: 'https://fabianoalves.adv.br/wp-content/uploads/2016/11/avatar-default-2.png',
                  );
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Favoritos'),
              subtitle: Text('mais informações...'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print('Item 1');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Sair'),
              subtitle: Text('mais informações...'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                UsuarioSessao.clearDadosUsuario();
                Navigator.pop(context);
                push(context, LoginPage(), replace: true);
              },
            ),
          ],
        ),
      ),
    );
  }

  UserAccountsDrawerHeader _drawerHeader(
      {String nome, String email, String urlFoto}) {
    return UserAccountsDrawerHeader(
      accountName: Text(nome),
      accountEmail: Text(email),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(urlFoto),
      ),
    );
  }

}
