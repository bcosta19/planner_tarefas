import 'dart:convert';


class Task {
  final int? id;
  late final int user_id;
  late final int board_id;
  late final String title;
  late final String note;
  late final String date;
  late final String startTime;
  late final String endTime;
  final int isCompleted;

  Task(
      {this.id,
      required this.user_id,
      required this.board_id,
      required this.title,
      required this.note,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.isCompleted});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": this.id,
      "user_id": this.user_id,
      "board_id": this.board_id,
      "title": this.title,
      "note": this.note,
      "date": this.date,
      "startTime": this.startTime,
      "endTime": this.endTime,
      "isCompleted": this.isCompleted
    };
  }

  factory Task.fromMap(Map<String, dynamic> map){
    return Task(
      id: map["id"] ??= map["id"] as int,
      user_id: map["user_id"] as int,
      board_id: map["board_id"] as int,
      title: map["title"] as String,
      note: map["note"] as String,
      date: map["date"] as String,
      startTime: map["startTime"] as String,
      endTime: map["endTime"] as String,
      isCompleted: map["isCompleted"] as int
    );
  }

  String toJson() => jsonEncode(toMap());
  
  factory Task.fromJson(String source) => Task.fromMap(jsonDecode(source) as Map<String, dynamic>);

}
