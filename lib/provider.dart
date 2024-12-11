import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Model(),
      child: Scaffold(
        body: Consumer<Model>(
          builder: (context, model, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model._counter.toString(),
                  style: TextStyle(
                    color: Colors.blueGrey.shade400,
                    fontSize: 30,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.amberAccent.shade400),
                      onPressed: () {
                        model.increment();
                      },
                      child: Text(
                        "Add",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.amberAccent.shade400),
                      onPressed: () {
                        model.decrement();
                      },
                      child: Text(
                        "Subtract",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class Model extends ChangeNotifier {
  // ignore: unused_field
  int _counter = 0;

  increment() {
    _counter++;
    notifyListeners();
  }

  decrement() {
    if (_counter == 0) {
      return;
    }
    _counter--;
    notifyListeners();
  }
}
