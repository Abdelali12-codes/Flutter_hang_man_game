// import 'package:flutter_tutorials/get_state/app_model.dart';
import 'dart:async';
import 'dart:math';

import 'package:frideos/frideos.dart';

class HangManState extends AppStateModel {
  factory HangManState() => instance();
  StreamedValue<int> counter = StreamedValue<int>(initialData: 10);

  // StreamedTransformed<String, int> streamedKey =
  //     StreamedTransformed<String, int>();
  // // In the BLoC clas

  // final validatekey = StreamTransformer.fromHandlers(handleData: (str, sink) {
  //   var k = int.tryParse(str);
  //   if (k != null) {
  //     print(str);
  //     sink.add((k + 1));
  //   } else {
  //     sink.addError('The key must be an interger');
  //   }
  // });

  static HangManState instance() => HangManState.internal();
  HangManState.internal() {
    print("the instance of the class");
    // streamedKey.value = 10.toString();
    // streamedKey.setTransformer(validatekey);
  }

  void increment() {
    counter.value++;
  }

  void decrement() {
    counter.value--;
  }

  @override
  void dispose() {
    print("the dispose method");
  }

  @override
  void init() {
    print("the init method");
  }
}
