import 'package:flutter/material.dart';
import 'package:project/dict/colors.dart';
import 'package:project/todo.dart';

class Item extends StatelessWidget {
  final Todo todo;
  final onToDoChanged;
  final onDeleteItem;
  final onEditItem;

  Item({Key? key, required this.todo, required this.onToDoChanged, required this.onDeleteItem, required this.onEditItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          onTap: () {
            onToDoChanged(todo);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          tileColor: Colors.white,
          leading: Icon(
              todo.isCompleted!
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              color: Blue),
          title: Text(
            todo.text!,
            style: TextStyle(
              fontSize: 16,
              color: Black,
              decoration: todo.isCompleted! ? TextDecoration.lineThrough : null,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(todo.description!,style: TextStyle(color: Grey),),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: Blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: IconButton(
                  icon: Icon(Icons.edit),
                  iconSize: 18,
                  color: Colors.white,
                  onPressed: () {
                    onEditItem(todo);
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.symmetric(vertical: 8),
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: Red,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: IconButton(
                  icon: Icon(Icons.delete),
                  iconSize: 18,
                  color: Colors.white,
                  onPressed: () {
                    onDeleteItem(todo.id);
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
