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
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () =>
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const AddPage())),
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
                            child: Container(
                              width: 150,
                              height: 50,
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
