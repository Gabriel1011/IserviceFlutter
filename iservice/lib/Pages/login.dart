import 'package:flutter/material.dart';
import 'package:todo/Pages/recuperar_senha.dart';
import 'package:todo/Widget/botao_inicial.dart';
import 'package:todo/Widget/inicio_tela.dart';
import 'package:todo/pages/cadastro_usuario.dart';
import 'package:todo/services/api.dart';
import 'package:todo/widget/campo_inicial.dart';

import 'cardViewCategoria.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _ctrlLogin = TextEditingController();
  final _ctrlSenha = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              InicioTela("IS", 60, textoFilho: "Login"),
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: corpoTela(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container corpoTela(BuildContext context) {
    var buttonLogin = BotaoInicial(() {
      _clickButton(context);
    }, "Entrar", 30);

    return Container(
      padding: EdgeInsets.only(top: 40),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            CampoInicial('Email', Icons.email, _ctrlLogin),
            CampoInicial('Senha', Icons.vpn_key, _ctrlSenha,
                margin: 40, textoSecreto: true),
            recuperarSenha(),
            buttonLogin,
            acessarCom(),
            botaoRedesocialLinha(),
            cadastreSe()
          ],
        ),
      ),
    );
  }

  void _clickButton(BuildContext context) async {
    bool formOk = _formKey.currentState.validate();

    if (!formOk) return;

    String login = _ctrlLogin.text;
    String senha = _ctrlSenha.text;

    print("login: $login senh: $senha");

    var usuario = await API.postLogin(login, senha);

    if (usuario != null && usuario.erros == null)
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CardCategoria()));

    print("Chegou!!!");
    AlertDialog(title: Text("login"), content: Text("Login invalido"));
  }

  Widget acessarCom() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          Text(
            '- Acessar com -',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget botaoRedesocialLinha() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          botaoRedesocial(
            () => print('Login with Facebook'),
            AssetImage(
              'imagens/facebook.jpg',
            ),
          ),
          botaoRedesocial(
            () => print('Login with Google'),
            AssetImage(
              'imagens/google.jpg',
            ),
          ),
        ],
      ),
    );
  }

  Widget botaoRedesocial(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 45.0,
          width: 45.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 6.0,
              ),
            ],
            image: DecorationImage(
              image: logo,
            ),
          ),
        ),
      ),
    );
  }

  Widget recuperarSenha() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 16, right: 32),
        child: InkWell(
          child: Text(
            'Esqueceu sua senha?',
            style: TextStyle(color: Colors.grey),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RecuperarSenha()));
          },
        ),
      ),
    );
  }

  Widget cadastreSe() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CadastroUsuario()));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Align(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Não possui uma conta? ',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: 'Registre-se',
                  style: TextStyle(
                    color: Color(0xFFf5851f),
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
