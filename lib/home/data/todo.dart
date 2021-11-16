// de el hya 2wel collection kol ma ha3ml collection ha3mlaha class leha

class Todo {
  static const String COLLECTION_KEY = 'Todos';
  String id; // dah el id bta3 kol document
  String title;
  String description;
  DateTime dateTime;
  bool isDone;

  Todo(
      {required this.id,
      required this.title,
      required this.description,
      required this.dateTime,
      this.isDone = false});

  Todo.fromJson(
      Map<String, Object?>
          json) //ba5od el data mn el firebase w 3ayz 2a7awelha le todo item
      : this(
          // basta5dmha lma bagy 22ra el data
          id: json['id']! as String,
          title: json['title']! as String,
          description: json['description']! as String,
          dateTime:
              DateTime.fromMillisecondsSinceEpoch(json['dateTime']! as int),
          isDone: json['isDone'] as bool,
        );

  Map<String, Object?> toJson() {
    //lma 2agy 2kteb 3ala el firestore
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'isDone': isDone,
    };
  }
}
