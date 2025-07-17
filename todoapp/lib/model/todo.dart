class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '1', todoText: 'Hello1', isDone: true),
      ToDo(id: '2', todoText: 'Hello2'),
      ToDo(id: '3', todoText: 'Hello3'),
    ];
  }
}
