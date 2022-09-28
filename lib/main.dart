import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const request = "https://api.hgbrasil.com/finance";

void main() async {
  runApp(MaterialApp(
    home: const Home(),
    theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintStyle: TextStyle(color: Colors.amber),
        )),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(Uri.parse(request));
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late double dolar;
  late double euro;

  TextEditingController realController = TextEditingController();
  TextEditingController dolarController = TextEditingController();
  TextEditingController euroController = TextEditingController();

  void _realChanged(String text) {
    print(text);
  }

  void _dolarChanged(String text) {
    print(text);
  }

  void _euroChanged(String text) {
    print(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Conversor de Moedas \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: Text(
                  "Carregando Dados ...",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              );

            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    "Erro ao carregar os dados :(",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                dolar = snapshot.data?["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data?["results"]["currencies"]["EUR"]["buy"];

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Icon(
                          Icons.monetization_on,
                          size: 150,
                          color: Colors.amber,
                        ),
                      ),
                      const Divider(height: 40.0),
                      buildTextField(
                        "Reais",
                        "R\$ ",
                        context,
                        realController,
                        _realChanged,
                      ),
                      const Divider(),
                      buildTextField(
                        "Dólares",
                        "US\$ ",
                        context,
                        dolarController,
                        _dolarChanged,
                      ),
                      const Divider(),
                      buildTextField(
                        "Euros",
                        "€ ",
                        context,
                        euroController,
                        _euroChanged,
                      ),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

Widget buildTextField(
  String label,
  String prefix,
  context,
  TextEditingController controller,
  void Function(String)? func,
) {
  return TextField(
    controller: controller,
    onChanged: func,
    decoration: InputDecoration(
      prefixText: prefix,
      labelText: label,
      labelStyle: const TextStyle(color: Colors.amber),
      border: const OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).hintColor)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor)),
    ),
    style: const TextStyle(
      color: Colors.amber,
      fontSize: 25.0,
    ),
    keyboardType: TextInputType.number,
  );
}
