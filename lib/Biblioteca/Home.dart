import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'FuncoesCamera.dart';
import 'Login.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    Future<void> _signOut() async {
      await FirebaseAuth.instance.signOut();
    }

    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text('Sistema ILI 1.0'),
        backgroundColor: Colors.grey[900],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 35,
          ),
          Row(
            children: [
              SizedBox(
                width: 30,
              ),
              Container(
                height: 50,
                child: Builder(
                  builder: (context) => ElevatedButton.icon(
                    onPressed: () async {
                      Map<Permission, PermissionStatus> statuses = await [
                        Permission.camera,
                      ].request();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Camera(),
                        ),
                      );
                    },
                    icon: Icon(Icons.camera_alt),
                    label: Text("Câmera"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 94, 104, 107)),
                  ),
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Container(
                height: 50,
                child: Builder(
                  builder: (context) => ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                    },
                    icon: Icon(Icons.verified_user),
                    label: Text("Login"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 94, 104, 107)),
                  ),
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Container(
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                  label: Text("Perdidos"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 94, 104, 107)),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            children: [
              SizedBox(
                width: 30.0,
              ),
              Container(
                height: 50,
                width: 113,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.person_add),
                  label: Text("Add"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 94, 104, 107)),
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Container(
                height: 50,
                width: 100,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.edit),
                  label: Text("Editar"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 94, 104, 107)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
