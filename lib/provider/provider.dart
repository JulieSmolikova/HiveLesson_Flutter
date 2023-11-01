import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../model/boxes.dart';
import '../model/model.dart';

class Data with ChangeNotifier {

  //Add
  Future addToBase() async{
    final something = Model()
      ..text = textController.text.trim()
      ..number = int.parse(numberController.text)
      ..color = switchValue;
    final box = Boxes.addToBase();
    box.add(something);
  }

  bool switchValue = true;
  final TextEditingController textController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  void switchColor(bool value){
    switchValue = !switchValue;
    switchValue = value;
    notifyListeners();
  }

  //delete
  void deleteTask(Box<Model> box, int index){
    box.deleteAt(index);
  }

  //edit


}