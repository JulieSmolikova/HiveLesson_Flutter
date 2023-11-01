import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_lesson/pages/main_page.dart';
import 'package:provider/provider.dart';
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
                    onPressed: () =>
                      Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) =>
                        const MainPage())),
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
                  ElevatedButton(
                      onPressed: () => data.addToBase(),
                      child: const Text('Add to base'))
                ],
              ),
            )
        );
      },
    );
  }
}



