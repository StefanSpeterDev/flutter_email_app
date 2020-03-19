import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message{
  final String subject;
  final String body;

  Message(this.subject, this.body);

  // Constructor that tells dart that when he receives a map, here is how to translate it into an instance of message
  factory Message.fromJson(Map<String, dynamic> json)
      => _$MessageFromJson(json);

}