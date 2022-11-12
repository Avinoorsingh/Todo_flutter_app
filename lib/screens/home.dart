import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Fetched todoList.
  final todosList = Todo.todoList();
  
  //return searched Todos relevant to the keyword that user entered. 
  List<Todo> searchedTodo = [];
  
  //controller for todo to be added.
  final todoController = TextEditingController();
  
  //changed to true when clicked on add button.
  bool showAdd = false;
  
  //changed to true when clicked on searched button.
  bool showSearch = false;

  //changed to true when there noTodo is present (no todo is relevant to the todo that the user searched for).
  bool noTodo = false;

  @override
  void initState() {
    searchedTodo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      bottomNavigationBar: bottomAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                //when there is no ToDo found for the user search!
                if (noTodo == true) ...{
                  Container(
                    padding: const EdgeInsets.all(50),
                    child: const Text(
                      "Your search has no results!",
                      style: TextStyle(color: grey),
                    ),
                  )
                },
                Expanded(
                  child: ListView(
                    children: [
                      for (Todo todoo in searchedTodo.reversed)
                        TodoItem(
                          todo: todoo,
                          onToDoChanged: handleTodoChange,
                          onDeleteItem: deleteTodo,
                        ),
                    ],
                  ),
                ),
                if (showSearch == true) ...{
                  searchBox(),
                },
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              if (showAdd == true) ...{
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: todoController,
                      decoration: InputDecoration(
                        hintText: 'Add a new todo',
                        border: InputBorder.none,
                        suffixIcon: ElevatedButton(
                          onPressed: () {
                            if (todoController.text.isNotEmpty) {
                              addTodo(todoController.text);
                            } else {
                              //empty todo will not be saved!
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white70,
                            foregroundColor: greenShade,
                            shadowColor: Colors.transparent,
                            elevation: 0,
                          ),
                          child: const Icon(Icons.send_sharp),
                        ),
                      ),
                    ),
                  ),
                ),
              } else ...{
                const SizedBox(height: 20),
              }
            ]),
          ),
        ],
      ),
    );
  }

//function that is called when todo is selected or unselected
  void handleTodoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

//function to delete the todo
  void deleteTodo(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

//function to add the todo
  void addTodo(String toDo) {
    setState(() {
      todosList.add(Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
      showAdd = !showAdd;
    });
    todoController.clear();
  }

//return the searched todos
  void filterTodo(String enteredKeyword) {
    List<Todo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    if (results.isEmpty) {
      setState(() {
        noTodo = true;
      });
    } else if (results.isNotEmpty) {
      setState(() {
        noTodo = false;
      });
    }
    setState(() {
      searchedTodo = results;
    });
  }

//searchBox Widget
  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => filterTodo(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: textColor,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: grey),
        ),
      ),
    );
  }


//bottom navigation bar of the app 
//List       Add        Search
  BottomNavigationBar bottomAppBar() {
    return BottomNavigationBar(
      selectedItemColor: greenShade,
      backgroundColor: white,
      elevation: 20,
      iconSize: 60.0,
      items: [
        BottomNavigationBarItem(
          icon: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
            Icon(
              Icons.list,
              size: 40.0,
              color: greenShade,
            ),
          ]),
          label: 'TODO',
        ),
        BottomNavigationBarItem(
            icon: Container(
              alignment: Alignment.topCenter,
              child: Ink(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(50.0)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    child: const Icon(
                      Icons.add,
                      size: 64.0,
                    ),
                  )),
            ),
            label: ''),
        const BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 40.0,
            ),
            label: ''),
      ],
      onTap: (int value) {
        //value==1 for showAdd Widget
        if (value == 1) {
          setState(() {
            showAdd = !showAdd;
            showSearch = false;
          });
        }
        //value==2 for showSearch Widget
        if (value == 2) {
          setState(() {
            showSearch = !showSearch;
            showAdd = false;
          });
        }
      },
    );
  }
}
