import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_lesson/pages/add_page.dart';
import 'package:provider/provider.dart';
import '../model/boxes.dart';
import '../model/model.dart';
import '../provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(
      builder: (context, data, _) {
        return Scaffold(
          appBar: AppBar(
            title: Center(child: Text ('Hive Lesson', style: TextStyle(fontSize: 30, color: Colors.black.withOpacity(0.7)),)),
            backgroundColor: Colors.lightBlueAccent.withOpacity(0.5),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      data.isEdit = false;
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(
                              builder: (context) =>
                              const AddPage()));
                    },
                    child: const Text('Add')
                ),
                Container(
                  height: 600,
                  width: 300,
                  color: Colors.grey,
                  child: ValueListenableBuilder<Box<Model>>(
                    valueListenable: Boxes.addToBase().listenable(),
                    builder: (context, box, _){
                      final value = box.values.toList().cast<Model>();
                      return ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index){
                          return GestureDetector(
                            onLongPress: () => data.deleteTask(box, index),
                            onDoubleTap: () {
                              data.isEdit = true;
                              data.editTask(index, value[index].text, value[index].number, value[index].color, box);
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) =>
                                  const AddPage()));
                            },
                            child: Container(
                              width: 150,
                              height: 50,
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              color: value[index].color ? Colors.blue : Colors.red,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(value[index].text),
                                  Text(value[index].number.toString()),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
