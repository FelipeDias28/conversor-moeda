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
                      TextField(
                        decoration: InputDecoration(
                          prefixText: "R\$ ",
                          labelText: "Reais",
                          labelStyle: const TextStyle(color: Colors.amber),
                          border: const OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).hintColor)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor)),
                        ),
                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 25.0,
                        ),
                      ),
                      const Divider(),
                      TextField(
                        decoration: InputDecoration(
                          prefixText: "US\$ ",
                          labelText: "Dólares",
                          labelStyle: const TextStyle(color: Colors.amber),
                          border: const OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).hintColor)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor)),
                        ),
                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 25.0,
                        ),
                      ),
                      const Divider(),
                      TextField(
                        decoration: InputDecoration(
                          prefixText: "€",
                          labelText: "Euros",
                          labelStyle: const TextStyle(color: Colors.amber),
                          border: const OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).hintColor)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor)),
                        ),
                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 25.0,
                        ),
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
