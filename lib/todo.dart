class Todo {
  String? id;
  String? text;
  String? description;
  bool? isCompleted;

  Todo({
    required this.id,
    required this.text,
    this.description = '',
    this.isCompleted = false,
  });

}
