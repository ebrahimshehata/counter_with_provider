import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CounterProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("counter with Provider"),
        centerTitle: true,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Provider.of<CounterProvider>(context, listen: false)
                      .decrementCounter();
                },
                child: const Icon(Icons.remove)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button',
                ),
                //Inherit+Control widget`s rebuild
                Consumer<CounterProvider>(
                  builder: (
                    context,
                    provider,
                    child,
                  ) {
                    return Text(provider.counter.toString());
                  },
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  Provider.of<CounterProvider>(context, listen: false)
                      .incrementCounter();
                },
                child: const Icon(Icons.add)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //Inherit
        onPressed: () {
          Provider.of<CounterProvider>(context, listen: false).restartCounter();
        },
        tooltip: 'restart',
        child: const Icon(Icons.restart_alt),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class CounterProvider extends ChangeNotifier {
  int counter = 0;

  void incrementCounter() {
    counter++;
    if (kDebugMode) {
      print("Counter $counter");
    }
    notifyListeners();
  }

  void decrementCounter() {
    counter--;
    if (kDebugMode) {
      print("Counter $counter");
    }
    notifyListeners();
  }

  void restartCounter() {
    counter = 0;
    if (kDebugMode) {
      print("Counter $counter");
    }
    notifyListeners();
  }
}
