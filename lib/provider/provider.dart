import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../model/boxes.dart';
import '../model/model.dart';

class Data with ChangeNotifier {

  final TextEditingController textController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  bool switchValue = true;

  void switchColor(bool value){
    switchValue = !switchValue;
    switchValue = value;
    notifyListeners();
  }

  //Add
  Future addToBase() async{
    final box = Boxes.addToBase();
    final task = Model()
      ..text = textController.text.trim()
      ..number = int.parse(numberController.text)
      ..color = switchValue;

    box.add(task);
  }

  //delete
  void deleteTask(Box<Model> box, int index){
    box.deleteAt(index);
  }

  //edit
  int editIndex = 0;
  bool isEdit = true; //показывает пришли мы на стр. добавлять запись или редактировать.

  void editTask(int index, String name, int number, bool color, Box<Model> box){
    textController.text = name;
    numberController.text = number.toString();
    switchValue = color;
    editIndex = index;
    notifyListeners();
  }  //функция editTask нужна, чтобы заходя на страницу редактирования из бд загружались имеющиеся значения, которые нужно отредактировать.
     //Значения есть на главной стр, тут мы их просто забираем в функцию и показываем на стр. редактирования (она же страница добавления).

  void editToBase(int index, String name, int number, bool color, Box<Model> box){
    box.putAt(index, Model()
      ..text = name
      ..number = number
      ..color = color
    );
  }  //2-я функция editToBase записывает уже отредактированные данные в бд. (Когда мы исп-ли box.add то значения добавляются в конец бд. Тут исп-ем
     //putAt и index, то есть заменяем в бд, если уже что-то есть, по этому index).

}