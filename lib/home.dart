import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerCep = TextEditingController();
  String _resultado = 'Resultado';

  Future<void> _recuperarCep() async {
    String cepDigitado = _controllerCep.text;
    String url = "https://viacep.com.br/ws/" + cepDigitado + "/json/";
    http.Response response = await http.get(Uri.parse(url));
    print("response: $response.body");

    Map<String, dynamic> retorno = json.decode(response.body);
    print("retorno: $retorno");
    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"] ?? "";
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];

    setState(() {
      _resultado = "$logradouro, $complemento, $bairro";
    });
    print(
        "Resposta logradouro: $logradouro complemento: $complemento bairro: $bairro ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consumo de Serviços Web'),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(labelText: "Digite o CEP: ex. 56280000."),
              style: TextStyle(fontSize: 20),
              controller: _controllerCep,
            ),
            ElevatedButton(
                onPressed: _recuperarCep, child: Text('Clique aqui')),
            Text(_resultado),
          ],
        ),
      ),
    );
  }
}
