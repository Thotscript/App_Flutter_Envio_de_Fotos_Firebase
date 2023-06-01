import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Home.dart';
import 'dart:async';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  String email = '';
  String password = '';

  bool showSuccessIcon = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        setState(() {
          showSuccessIcon = true;
        });

        Timer(Duration(seconds: 5), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        });
      }
    } catch (e) {
      print('Erro ao fazer login: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 230.0),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Container(
              child: Text("Log in"),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 20.0),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email:"),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(50.0, 0, 50.0, 0),
            child: TextFormField(
              controller: senhaController,
              decoration: InputDecoration(labelText: "Senha:"),
            ),
          ),
          SizedBox(height: 35.0),
          ElevatedButton(
            onPressed: () {
              String email = emailController.text.trim();
              String senha = senhaController.text.trim();
              signIn(email, senha);
            },
            child: Text('Fazer login'),
          ),
        ],
      ),
    );
  }
}
