class Record {
  final String content;
  final List<Map<String, dynamic>> statusChanges;

  Record({
    required this.content,
    required this.statusChanges,
  });

  Map<String, dynamic> toJson() => {
        'content': content,
        'statusChanges': statusChanges,
      };

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        content: json['content'] as String,
        statusChanges: List<Map<String, dynamic>>.from(
            json['statusChanges'].map((x) => Map<String, dynamic>.from(x))),
      );
}