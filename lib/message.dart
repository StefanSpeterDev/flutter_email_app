import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message{
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

}