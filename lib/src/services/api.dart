import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

uploadImage(File image) async {
  String addressUri = 'https://codelime.in/api/remind-app-token';
  var request = http.MultipartRequest("POST", Uri.parse(addressUri));
  var img = await http.MultipartFile.fromPath("file", image.path,contentType: new MediaType('image', 'png'));
  request.files.add(img);
  var response = await request.send();
  var responseData = await response.stream.toBytes();
  var responseString = String.fromCharCodes(responseData);
  if (kDebugMode) {
    print(responseString);
  }
}
