import 'dart:async';

import 'package:flutter/material.dart';

// реализуем наш клас который будет содержать наш блок
// создадим  enum который будет содержать событие
enum ColorEvent { event_red, event_green }

class ColorBloc {
  // положем значение цвета который будем менять
  Color _color = Colors.red;

  //  создаем stream_controller
  final _inputEventController = StreamController<ColorEvent>();

// напишем геттер для входного потока
  StreamSink<ColorEvent> get inputEventSink => _inputEventController.sink;

// создадим streamController для нового состояния которок будет содержать в себе тип color
  final _outputStateController = StreamController<Color>();

// напишем гетер для выходного состояния
  Stream<Color> get outputStateStream => _outputStateController.stream;

//где Stream это выходной поток
//нужно реализовать метод который будет преобразовывать события  в новое состояние
  void _mapEventToState(ColorEvent event) {
    if (event == ColorEvent.event_red)
      _color = Colors.red;
    else if (event == ColorEvent.event_green)
      _color = Colors.green;
    else
      throw Exception('Wrong Event Type');
    //просле того как мы получим новое состояние в заваисимости от состояния, его нужно добаваить в выходной поток
    // используя метод add
    _outputStateController.sink.add(_color);
  }

  // нужно подписаться на прослушивание выходеого потока для нового состояния
// для этого создадим конструктор
  ColorBloc() {
    _inputEventController.stream.listen(_mapEventToState);
  }
  // по окончанию потоков их надо закрыть
void dispose(){
    _inputEventController.close();
    _outputStateController.close();
}
}
