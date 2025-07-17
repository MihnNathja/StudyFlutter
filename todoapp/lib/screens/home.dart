import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../widgets/todo_item.dart';
import '../model/todo.dart';

class Home extends StatefulWidget {
  Home ({Key? key}): super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  final _todoController = TextEditingController();
  List<ToDo> _foundToDo = [];

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10
            ),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: 50,
                              bottom: 20
                          ),
                          child: Text(
                              "All Todos",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30
                              )
                          ),
                        ),
                        for (ToDo todoo in _foundToDo)
                          ToDoItem(
                              todo: todoo,
                            onToDoChanged: _handleToDoChange,
                            onDeleteItem: _deleteToDoItem,
                          )

                      ],
                    )
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: 20,
                        right: 20,
                        left: 20
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0
                        ),],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _todoController,
                        decoration: InputDecoration(
                          hintText: 'Add a new todo item',
                          border: InputBorder.none
                        ),
                      ),
                    )
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      _addToDoItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tdBlue,
                      minimumSize: Size(60, 60),
                      elevation: 10
                    ),
                    child: Text(
                      '+',
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.white
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String todo) {
    setState(() {
      todosList.add(ToDo(id: DateTime.now().microsecondsSinceEpoch.toString(), todoText: todo));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyboard) {
    List<ToDo> results = [];

    if(enteredKeyboard.isEmpty) {
      results = todosList;
    } else {
      results = todosList.where((item) => item.todoText!.toLowerCase().contains(enteredKeyboard.toLowerCase())).toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }

  Container searchBox() {
    return Container(
            padding: EdgeInsets.symmetric(
                horizontal: 15
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
            child: TextField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(
                  Icons.search,
                  color: tdBlack,
                  size: 20,
                ),
                prefixIconConstraints: BoxConstraints(
                    maxHeight: 20,
                    minWidth: 25
                ),
                hintText: "Search"
              ),
            ),
          );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(20),
              child: Image(image: AssetImage('image/avatar.jpg'))
            ),
          )
        ],
      ),
    );
  }
}