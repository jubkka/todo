import 'package:flutter/material.dart';

import 'dict/colors.dart';

class editingTodoItem extends StatelessWidget {
  final String nameTask;
  final String descriptionTask;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List<String> data = [];

  editingTodoItem({
    Key? key,
    required this.nameTask,
    required this.descriptionTask,
  }) : super(key: key);

  String finalNameTask = '';
  String finalDescriptionTask = '';

  @override
  Widget build(BuildContext context) {
    nameController.text = nameTask;
    descriptionController.text = descriptionTask;

    finalNameTask = nameTask;
    finalDescriptionTask = descriptionTask;

    return Scaffold(
      appBar: AppBar(
        title: Text("Изменение задачи"),
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
                    controller: nameController,
                    maxLength: 64,
                    onChanged: (value) { finalNameTask = value; },
                    decoration: InputDecoration(
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
                    controller: descriptionController,
                    maxLength: 100,
                    expands: true,
                    maxLines: null,
                    minLines: null,
                    onChanged: (value) { finalDescriptionTask = value; },
                    decoration: InputDecoration(
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
                      if (finalNameTask!.isEmpty) {
                        return;
                      } else {
                        data.add(finalNameTask!);
                      }

                      if (finalDescriptionTask!.isNotEmpty) data.add(finalDescriptionTask!);
                      else data.add('...');

                      Navigator.pop(context, data);
                      },
                    child: Text('Изменить', style: TextStyle(color: Colors.white),),
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