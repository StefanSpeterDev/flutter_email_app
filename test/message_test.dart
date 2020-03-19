import 'dart:convert';

import 'package:email_app/message.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  test('Message can be created from json string', () async {

    // given
    String jsonString = '{"subject":"someSubject", "body": "someBody"}';
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    // when
    Message message = Message.fromJson(jsonMap);

    // then
    expect(message.subject, equals("someSubject"));
    expect(message.body, equals("someBody"));

  });

}