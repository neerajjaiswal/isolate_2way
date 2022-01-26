

import 'dart:async';
import 'dart:isolate';

import '../handlers/main_handle.dart';
import 'child_isolate.dart';

class MainIsolate{
  static SendPort? mainToChildStream;
  static MainHandler? handler;

  static init() async{
    mainToChildStream = await setup();
  }

  static Future<SendPort> setup() async {
    Completer<SendPort> completer = Completer<SendPort>();
    ReceivePort childToMainStream = ReceivePort();

    childToMainStream.listen((data) {
      if (data is SendPort) {
        SendPort mainToIsolateStream = data;
        completer.complete(mainToIsolateStream);
      }
      else{
        print('[main received json] $data');
        handler!.handleMessage(data);
      }
    });

    await Isolate.spawn(ChildIsolate.setup, childToMainStream.sendPort);
    return completer.future;
  }

  static sendToChild(String msg){
    mainToChildStream!.send(msg);
  }

}