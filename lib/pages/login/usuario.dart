class Usuario {
  int _id;
  String _login;
  String _nome;
  String _email;
  String _urlFoto;
  String _token;
  List<String> _roles;


  int get id => _id;

  set id(int value) {
    _id = value;
  }

  Usuario.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    nome = json['nome'];
    email = json['email'];
    urlFoto = json['urlFoto'];
    token = json['token'];
    roles = json['roles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login'] = this.login;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['urlFoto'] = this.urlFoto;
    data['token'] = this.token;
    data['roles'] = this.roles;
    return data;
  }

  @override
  String toString() {
    return 'Usuario{id: $id, login: $login, nome: $nome, email: $email, urlFoto: $urlFoto, token: $token, roles: $roles}';
  }

  String get login => _login;

  set login(String value) {
    _login = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get urlFoto => _urlFoto;

  set urlFoto(String value) {
    _urlFoto = value;
  }

  String get token => _token;

  set token(String value) {
    _token = value;
  }

  List<String> get roles => _roles;

  set roles(List<String> value) {
    _roles = value;
  }
}