import 'dart:ffi';

import 'package:flutter/material.dart';

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
      home: const _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  int _count = 1;

  @override
  Widget build(BuildContext context) {
    return _Inherited(
      message: _createMessage(),
      count: _count,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () => setState(() => _count++),
        ),
        body: Center(
          child: const _Message(),
        ),
      ),
    );
  }

  String _createMessage() {
    final result = _count % 15 == 0
      ? 'FizzBuzz'
      : (_count % 3 == 0 ? 'Fizz' : (_count % 5 == 0 ? 'Buzz' : '-'));
    
    print('_count $_count, result $result');
    return result;
  }
}

class _Message extends StatelessWidget {
  const _Message({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('_Message: rebuild');
    return Text(
      'Message${_Inherited.of(context, listen: true).count}: ${_Inherited.of(
        context,
        listen: true,
      ).message}',
      style: TextStyle(fontSize: 64.0),
    );
  }
}

class _Inherited extends InheritedWidget {
  const _Inherited({
    Key key,
    @required this.message,
    @required this.count,
    @required Widget child,
  }) : super(key: key, child: child);

  final String message;
  final int count;
  
  static _Inherited of(
    BuildContext context, {
      @required bool listen,
    }) {
      return listen
        ? context.dependOnInheritedWidgetOfExactType<_Inherited>()
        : context.getElementForInheritedWidgetOfExactType<_Inherited>()
            .widget as _Inherited;
    }
  
  @override
  bool updateShouldNotify(_Inherited old) => message != old.message;
}


