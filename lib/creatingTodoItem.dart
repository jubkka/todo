import 'package:flutter/material.dart';

import 'dict/colors.dart';

class createTodoWidget extends StatelessWidget {
  String? nameTask = '';
  String? descriptionTask = '';
  List<String> data = [];

  createTodoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Создание новой задачи"),
        backgroundColor: BGColor,
      ),
      body: Container(
        color: BGColor,
        child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 55, vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    maxLength: 64,
                    onChanged: (value) { nameTask = value; },
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(4),
                        border: InputBorder.none,
                        hintText: 'Название',
                        hintStyle: TextStyle(color: Grey)),
                  ),
                ),
                Container(
                  height: 100,
                  margin: EdgeInsets.symmetric(horizontal: 55, vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    maxLength: 100,
                    expands: true,
                    maxLines: null,
                    minLines: null,
                    onChanged: (value) { descriptionTask = value; },
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(4),
                        border: InputBorder.none,
                        hintText: 'Описание',
                        hintStyle: TextStyle(color: Grey)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      if (nameTask!.isEmpty) {
                        return;
                      } else {
                        data.add(nameTask!);
                      }

                      if (descriptionTask!.isNotEmpty) data.add(descriptionTask!);
                      else data.add('...');

                      Navigator.pop(context, data);
                      },
                    child: Text('Добавить', style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Blue,
                      minimumSize: Size(65, 65),
                      elevation: 10,
                      shadowColor: Black,
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}