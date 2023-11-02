import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_lesson/pages/main_page.dart';
import 'package:provider/provider.dart';
import '../model/boxes.dart';
import '../model/model.dart';
import '../provider/provider.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(
      builder: (context, data, _) {
        return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      data.textController.clear(); //очистить поле, если выходишь со стр. Тогда при переходе, если isEdit = false (т.е. для add, а не edit) все поля будут чистыми.
                      data.numberController.clear(); //очистить поле, если выходишь со стр. Тогда при переходе, если isEdit = false (т.е. для add, а не edit) все поля будут чистыми.
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) =>
                          const MainPage()));
                    },
                    child: const Text('Back')
                  ),
                  TextField(
                    controller: data.textController,
                  ),
                  TextField(
                    controller: data.numberController,
                  ),
                  Container(
                    width: 200,
                    height: 100,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.red,
                          Colors.blue
                        ]
                      )
                    ),
                    child: CupertinoSwitch(
                      value: data.switchValue,
                      onChanged: (value) => data.switchColor(value),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: Boxes.addToBase().listenable(),
                    builder: (context, box, _){
                      final value = box.values.toList().cast<Model>();
                      return ElevatedButton(
                          onPressed: () => !data.isEdit
                            ? data.addToBase()
                            : data.editToBase(
                              data.editIndex,
                              data.textController.text,
                              int.parse(data.numberController.text),
                              data.switchValue,
                              box),
                          child: Text(
                              !data.isEdit
                                ? 'Add to Base'
                                : 'Edit to Base'));
                    },
                  )
                ],
              ),
            )
        );
      },
    );
  }
}



