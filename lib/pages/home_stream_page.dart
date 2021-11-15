import 'dart:async';

import 'package:flutter/material.dart';

class HomeStreamPage extends StatefulWidget {
  @override
  _HomeStreamPageState createState() => _HomeStreamPageState();
}

class _HomeStreamPageState extends State<HomeStreamPage> {
  StreamController<String> _streamController = new StreamController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Stream 1
    // Stream<String> myStream = new Stream.fromFuture(getData());
    // print("Stream creado");
    // myStream.listen((event) {
    //   print("Data::: $event");
    // },onDone: (){
    //   print("Data Done");
    // },onError: (error){
    //   print("Data error");
    // });
    // print("Code here.....");

    // Stream 2
    _streamController.stream.listen(
      (event) {
        print("Data recibida:::$event");
      },
      onDone: () {
        print("OnDone");

      },
      onError: (error) {},
    );
    _streamController.add("Hola muchachos");
    print("Code here");
  }

  Future<String> getData() async {
    await Future.delayed(Duration(seconds: 5));
    return "Data de prueba desde un Futuro";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _streamController.add("Mandarina");
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Stream"),
      ),
      body: Center(),
    );
  }
}
