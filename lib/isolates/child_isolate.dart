

import 'dart:isolate';

class ChildIsolate {
  static SendPort? _backgroundToMainStream;

  static setup(SendPort backgroundToMainStream) {
    _backgroundToMainStream = backgroundToMainStream;
    ReceivePort mainToIsolateStream = ReceivePort();
    backgroundToMainStream.send(mainToIsolateStream.sendPort);

    mainToIsolateStream.listen((data) {
        print('[background received] ${data}');
        handleMessage(data);
    });

    // isolateToMainStream.send('This is from myIsolate()');
  }

  static sendToMain(String msg){
    print('[background sent] $msg');
    _backgroundToMainStream!.send(msg);
  }

  static handleMessage(String data){
    sendToMain(data.toUpperCase());
  }
}