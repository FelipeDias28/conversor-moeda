import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const request = "https://api.hgbrasil.com/finance";

void main() async {
  http.Response response = await http.get(Uri.parse(request));
  print(json.decode(response.body)["results"]["currencies"]["USD"]);

  runApp(MaterialApp(home: Container()));
}
