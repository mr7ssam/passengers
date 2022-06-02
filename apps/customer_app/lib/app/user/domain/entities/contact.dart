class Contact {
  Contact({
    required this.type,
    required this.text,
  });

  final int type;
  final String text;

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'text': text,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      type: map['type'] as int,
      text: map['text'] as String,
    );
  }
}
