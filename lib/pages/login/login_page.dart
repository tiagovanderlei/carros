import 'dart:async';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/carro/home_page.dart';
import 'package:carros/pages/login/login_bloc.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/utils/prefs.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:carros/pages/login/login_api.dart';

import 'usuario_sessao.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _loginController = TextEditingController();

  TextEditingController _senhaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final FocusNode _focusSenha = FocusNode();
  bool _showProgress = false;
  LoginBloc _bloc = LoginBloc();

  @override
  void initState() {
    Future<Usuario> future = UsuarioSessao.getDadosUsuario();

    future.then((Usuario usuario) {
      setState(() {
        if (usuario != null) {
          push(context, HomePage(), replace: true);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carros'),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            AppText(
                label: 'Login',
                hint: 'digite o login',
                textController: _loginController,
                validator: _validateLogin,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: _onSubmittedTxLogin),
            SizedBox(height: 10),
            AppText(
                label: 'Senha',
                hint: 'digite a senha',
                textController: _senhaController,
                obscure: true,
                validator: _validateSenha,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                focusNode: _focusSenha
            ),
            SizedBox(height: 20),
            StreamBuilder<bool>(
              stream: _bloc.stream,
              builder: (context, snapshot) {

                return AppButton(
                  text: 'Login',
                  onPressed: _onPressedLogin,
                  showProgress: snapshot.data ?? false,
                );
              }
            ),
          ],
        ),
      ),
    );
  }

  void _onPressedLogin() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    ApiResponse<Usuario> response  = await _bloc.login(login: _loginController.text, senha: _senhaController.text);

    if (response.ok) {
      push(context, HomePage(), replace: true);
    } else {
      alert(context: context, msg: response.msg);
    }
  }

  String _validateLogin(String texto) {
    if (texto.trim().isEmpty) return 'Login é obrigatório';
    return null;
  }

  String _validateSenha(String texto) {
    if (texto.trim().isEmpty) return 'Senha é obrigatória';

    if (texto.trim().length < 3)
      return 'Senha deve possuir pelo menos 3 dígitos';

    return null;
  }

  void _onSubmittedTxLogin(String text) {
    FocusScope.of(context).requestFocus(_focusSenha);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
