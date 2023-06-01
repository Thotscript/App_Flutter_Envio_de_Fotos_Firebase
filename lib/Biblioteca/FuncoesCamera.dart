import 'dart:convert'; // Importa a biblioteca para lidar com codificação e decodificação de dados
import 'dart:io'; // Importa a biblioteca para lidar com operações de I/O
import 'dart:typed_data'; // Importa a biblioteca para lidar com arrays de bytes
import 'package:flutter/material.dart'; // Importa o pacote de widgets do Flutter
import 'package:flutter/src/widgets/framework.dart'; // Importa o pacote de widgets do Flutter (não é necessário importar explicitamente)
import 'package:flutter/src/widgets/placeholder.dart'; // Importa o pacote de widgets do Flutter (não é necessário importar explicitamente)
import 'package:image_picker/image_picker.dart'; // Importa o pacote para selecionar imagens da galeria ou câmera
import 'package:firebase_storage/firebase_storage.dart'
    as firebase_storage; // Importa o pacote do Firebase Storage

class Camera extends StatefulWidget {
  const Camera({Key? key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late File
      _image; // Declara uma variável para armazenar o arquivo de imagem selecionado

  String ImgEncode =
      ""; // Declara uma variável para armazenar a representação codificada da imagem

  // Função para capturar uma imagem da câmera
  Future getImage() async {
    final image = await ImagePicker().pickImage(
        source: ImageSource.camera); // Seleciona uma imagem da câmera
    if (image == null)
      return; // Verifica se a imagem foi selecionada corretamente
    final imageTemporary =
        File(image.path); // Cria um arquivo temporário com a imagem selecionada

    Uint8List imgbyte =
        await imageTemporary.readAsBytes(); // Lê os bytes da imagem
    print(imgbyte); // Imprime os bytes da imagem
    ImgEncode = base64.encode(
        imgbyte); // Codifica os bytes da imagem para uma string usando base64
    print(ImgEncode); // Imprime a representação codificada da imagem

    // Enviando a foto para o Firebase Storage
    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage
          .instance // Cria uma referência para o Firebase Storage
          .ref()
          .child(
              'Imagens_Validacao/${DateTime.now().millisecondsSinceEpoch}.jpg'); // Define o caminho para armazenar a imagem no Firebase Storage

      await ref.putFile(
          imageTemporary); // Envia o arquivo da imagem para o Firebase Storage

      String downloadURL = await ref
          .getDownloadURL(); // Obtém a URL de download da imagem do Firebase Storage
      print(
          'URL da imagem: $downloadURL'); // Imprime a URL de download da imagem
    } catch (e) {
      print(
          'Erro ao enviar a imagem: $e'); // Trata erros caso ocorram durante o envio da imagem para o Firebase Storage
    }
  }

  // Função para obter uma imagem da galeria
  Future getGalery() async {
    final image = await ImagePicker().pickImage(
        source: ImageSource.gallery); // Seleciona uma imagem da galeria
    if (image == null)
      return; // Verifica se a imagem foi selecionada corretamente
    final imageTemporary =
        File(image.path); // Cria um arquivo temporário com a imagem selecionada

    setState(() {
      this._image =
          imageTemporary; // Atualiza o estado do widget com a imagem selecionada
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text("Funções Câmera"),
        backgroundColor: Colors.grey[900],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              SizedBox(
                width: 45,
              ),
              Container(
                height: 50,
                width: 120,
                child: ElevatedButton.icon(
                  onPressed: getGalery,
                  icon: Icon(Icons.burst_mode_outlined),
                  label: Text("Galeria"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 94, 104, 107)),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Container(
                height: 50,
                width: 180,
                child: ElevatedButton.icon(
                  onPressed: getImage,
                  icon: Icon(Icons.emoji_emotions_outlined),
                  label: Text("Reconhecimento Facial"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 94, 104, 107)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
