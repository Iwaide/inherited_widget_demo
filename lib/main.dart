import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const App();
  }
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => _FizzBuzz(),
        child: const _HomePage(),
      ),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () =>
            Provider.of<_FizzBuzz>(context, listen: false).increment(),
      ),
      body: Center(
        child: const _Message(),
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('_Message: rebuild');
    return Text(
      'Message: ${Provider.of<_FizzBuzz>(context).message}',
      style: TextStyle(fontSize: 64.0),
    );
  }
}

class _FizzBuzz extends ValueNotifier {
  _FizzBuzz() : super(1);

  void increment () => value++;

  String get message{
    final result = value % 15 == 0
          ? 'FizzBuzz'
          : (value % 3 == 0 ? 'Fizz' : (value % 5 == 0 ? 'Buzz' : '-'));

    print('value $value, result $result');
    return result;
  }
}
