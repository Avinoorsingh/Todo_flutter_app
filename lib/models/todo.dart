
class Todo {
  String? id;
  String? todoText;
  bool isDone;

  Todo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<Todo> todoList() {
    return [
      Todo(id: '1', todoText: 'Buy birthday gift for John Doe'),
      Todo(id: '2', todoText: 'Send report email',isDone: true),
      Todo(id: '3', todoText: 'Be unproductive on the weekends',),
      Todo(id: '4', todoText: 'Print \'Hello World\'', isDone: true ),
      Todo(id: '5', todoText: 'Finish medium post', isDone: true),
      Todo(id: '6', todoText: 'Buy groceries', ),
      Todo(id: '7', todoText: 'Check-up appointment @5', ),
      Todo(id: '8', todoText: 'Pickup Friend', ),
    ];
  }
}