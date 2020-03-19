class Message{
  final String subject;
  final String body;

  Message(this.subject, this.body);

  // Constructor that tells dart that when he receives a map, here is how to translate it into an instance of message
  Message.fromJson(Map<String, dynamic> json) :
      subject = json['subject'],
      body = json['body'];

}