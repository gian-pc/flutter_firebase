import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeStreamPage extends StatefulWidget {
  @override
  _HomeStreamPageState createState() => _HomeStreamPageState();
}

class _HomeStreamPageState extends State<HomeStreamPage> {
  StreamController<Map> _streamController = new StreamController();

  List<Image> imageList = [
    Image.network("https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",fit: BoxFit.cover,),
    Image.network("https://images.pexels.com/photos/4063856/pexels-photo-4063856.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",fit: BoxFit.cover,),
    Image.network("https://images.pexels.com/photos/4063537/pexels-photo-4063537.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",fit: BoxFit.cover,),
    Image.network("https://images.pexels.com/photos/1771383/pexels-photo-1771383.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",fit: BoxFit.cover,),
  ];

  List<Map> mapList = [
    {
      "height":30.0,
      "width":100.0,
      "color":Colors.red,
      "radius":30.0,
      "duration":700,
    },
    {
      "height":200.0,
      "width":200.0,
      "color":Colors.blueAccent,
      "radius":60.0,
      "duration":700,
    },
    {
      "height":200.0,
      "width":20.0,
      "color":Colors.greenAccent,
      "radius":30.0,
      "duration":700,
    },
    {
      "height":30.0,
      "width":200.0,
      "color":Colors.deepPurpleAccent,
      "radius":30.0,
      "duration":700,
    }

  ];



  int _contador = -1;

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

    // _streamController.stream.listen(
    //   (event) {
    //     print("Data recibida:::$event");
    //   },
    //   onDone: () {
    //     print("OnDone");
    //   },
    //   onError: (error) {},
    // );
    // _streamController.add("Hola muchachos");
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
        onPressed: () {
          _contador++;
          if(_contador<imageList.length){
           _streamController.add(mapList[_contador]);
          }else{
            _streamController.close();
          }

        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Stream"),
      ),
      body: StreamBuilder(
        stream: _streamController.stream,
        builder: (BuildContext context, AsyncSnapshot snap) {
          if(snap.hasData){
            return Center(
              // child: ClipRRect(
              //   borderRadius: BorderRadius.circular(20.0),
              //   child: Container(
              //     height: 200,
              //     width: 200,
              //     child: snap.data,
              //   ),
              // )
              child: AnimatedContainer(
                width: snap.data["width"],
                height: snap.data["height"],
                duration: Duration(milliseconds: snap.data["duration"]),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(snap.data["radius"]),
                  color: snap.data["color"]
                ),
              ),
            );
          }
          return Center(
            child: Text("Waiting.."),
          );
        },
      ),
    );
  }
}
