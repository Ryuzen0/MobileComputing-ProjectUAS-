class TodoModel {
  final int id;
  final int userId;
  final String title;
  final int isDone;

  TodoModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.isDone,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: int.parse(json['id'].toString()),
      userId: int.parse(json['user_id'].toString()),
      title: json['title'],
      isDone: int.parse(json['is_done'].toString()),
    );
  }
}
