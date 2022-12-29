import 'package:bloc_stream/color_bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ColorBloc _bloc = ColorBloc();

  // добавим dispose что бы избежать утечки памяти
  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bloc with stream'),
          centerTitle: true,
        ),
        body: Center(
          child: StreamBuilder(
            stream: _bloc.outputStateStream,
            //устанавливаем изначальное значение нашего цвета
            initialData: Colors.red,
            builder: (context, snapshot) {
              return AnimatedContainer(
                height: 100,
                width: 100,
                color: snapshot.data,
                duration: Duration(microseconds: 500),
              );
            },
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                _bloc.inputEventSink.add(ColorEvent.event_red);
              },
              backgroundColor: Colors.red,
            ),
            SizedBox(width: 10),
            FloatingActionButton(
              onPressed: () {
                _bloc.inputEventSink.add(ColorEvent.event_green);
              },
              backgroundColor: Colors.green,
            ),
          ],
        ));
  }
}
