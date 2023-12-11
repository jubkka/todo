import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/dict/colors.dart';
import 'package:project/items.dart';
import 'package:project/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'editingTodoItem.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Todo> todoList = [];
  List<Todo> foundTodo = [];
  bool filter = false;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  Future<List<Todo>?> _loadData() async {
    todoList = (await loadData())!;
    foundTodo = todoList;
  }

  void _saveData() async {
    await saveData();
  }

  Future saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> ids = [];

    for (Todo todo in todoList) {
      Map<String, dynamic> task = {
        'id': todo.id,
        'text': todo.text,
        'description': todo.description,
        'isCompleted': todo.isCompleted
      };

      prefs.setString(todo.id.toString(), jsonEncode(task));
      ids.add(todo.id.toString());
    }

    prefs.setStringList('ids', ids);
  }

  Future<List<Todo>?> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Todo> loadedTodo = [];
    List<String>? loadId = prefs.getStringList('ids');

    if (loadId == null) return [];

    for (var i = 0; i < loadId!.length; i++) {
      String? task = prefs.getString(loadId[i]);

      Map<String, dynamic> taskMap = jsonDecode(task!) as Map<String, dynamic>;
      loadedTodo.add(Todo(
          id: taskMap['id'],
          text: taskMap['text'],
          description: taskMap['description'],
          isCompleted: taskMap['isCompleted']));
    }

    return loadedTodo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BGColor,
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Text(
                          !filter ? 'Активные задачи' : 'Завершенные задачи',
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                      if (!filter &&
                          foundTodo
                              .where((item) => item.isCompleted == false)
                              .isEmpty)
                        Text('Пусто...')
                      else if (filter &&
                          foundTodo
                              .where((item) => item.isCompleted == true)
                              .isEmpty)
                        Text('Пусто...'),

                      for (Todo todo in foundTodo.reversed)
                        if (filter && todo.isCompleted!)
                          Item(
                              todo: todo,
                              onToDoChanged: changeStateTodo,
                              onDeleteItem: deleteToDoItem, onEditItem: editTodoItem,)
                        else if (!filter && !todo.isCompleted!)
                          Item(
                              todo: todo,
                              onToDoChanged: changeStateTodo,
                              onDeleteItem: deleteToDoItem, onEditItem: editTodoItem,),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomPanel()
        ],
      ),
    );
  }

  Align bottomPanel() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20, left: 20),
              child: ElevatedButton(
                onPressed: () {
                  changeStateFilter();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Blue,
                  minimumSize: const Size(65, 65),
                  elevation: 10,
                  shadowColor: Black,
                ),
                child: Icon(Icons.filter_alt, size: 25, color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20, right: 20),
              child: ElevatedButton(
                onPressed: () {
                  _waitForData(context);
                },
                child: Icon(Icons.add, size: 25, color: Colors.white),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Blue,
                  minimumSize: Size(65, 65),
                  elevation: 10,
                  shadowColor: Black,
                ),
              ),
            ),
          ],
        ));
  }

  Container searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) {
          searchFilter(value);
        },
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(4),
            prefixIcon: Icon(Icons.search, color: Black, size: 20),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
            border: InputBorder.none,
            hintText: 'Поиск',
            hintStyle: TextStyle(color: Grey)),
      ),
    );
  }

  void changeStateFilter() {
    setState(() {
      filter = !filter;
    });
  }

  void searchFilter(String enteredKeyword) {
    List<Todo> results = [];

    if (enteredKeyword.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((item) =>
              item.text!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      foundTodo = results;
    });
  }

  void addTodoItem(List<String> data) {
    setState(() {
      todoList.add(Todo(
          id: DateTime.now().microsecondsSinceEpoch.toString(), text: data[0], description: data[1]));
    });
    _saveData();
  }

  void deleteToDoItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
    _saveData();
  }

  void editTodoItem(Todo todo) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => editingTodoItem(
            nameTask: todo.text!,
            descriptionTask: todo.description!,
        ),
      ),
    );
    setState(() {
      todo.text = result[0];
      todo.description = result[1];
    });
    _saveData();
  }

  void changeStateTodo(Todo todo) {
    setState(() {
      todo.isCompleted = !todo.isCompleted!;
    });
    _saveData();
  }

  _waitForData(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/create');
    if (result != null) addTodoItem(result as List<String>);
  }

}
