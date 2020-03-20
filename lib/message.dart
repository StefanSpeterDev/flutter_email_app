import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

part 'message.g.dart';

@JsonSerializable()
class Message {
  final String subject;
  final String body;

  Message(this.subject, this.body);

  // Constructor that tells dart that when he receives a map, here is how to translate it into an instance of message
  // Now use build_runner and json_serializable to automatically update the dart object with json's good values,
  // so we don't have to do it (like subject, body...)
  // We can check this file in the generated file message.g.dart (generated using :
  // flutter packages pub run build_runner build )
  factory Message.fromJson(Map<String, dynamic> json)
  => _$MessageFromJson(json);




  static Future<List<Message>> browse() async {
    // Fetch data from an online API (using http package)
    http.Response response =
    await http.get('http://www.mocky.io/v2/5e7385093000007c282e6652');

    await Future.delayed(Duration(seconds: 3));
    String content = response.body;

    // Translate from json to dart object
    List collection = json.decode(content);

    // List<Message> fait référence au fichier Message.
    List<Message> _messages =
    collection.map((json) => Message.fromJson(json)).toList();
    // On lui indique que collection est une list d'élément définit dans message.dart
    // [1,2,3,4].map((el) => el + 1) --> [2,3,4,5]

    return _messages;
  }
}

