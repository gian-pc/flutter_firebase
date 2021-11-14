import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map> myBands = [];
  CollectionReference bandCollection =
      FirebaseFirestore.instance.collection('bandas');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllDataFirebase();
  }

  getAllDataFirebase() {
    print("Message:::::$bandCollection");
    bandCollection.get().then((value) {
      print("value::::::${value.docs.runtimeType}");
      value.docs.forEach((element) {
        //print("Document:::::${element.data()}");
        Map<String, dynamic> myMap = element.data() as Map<String, dynamic>;
        myBands.add(myMap);
        setState(() {});
      });
    });
  }

  getDocumentFirebase() {
    bandCollection.doc("mVCbEnqjZ8rShpQIGlB4").get().then((value) {
      if (value.exists) {
        print("Band::::::${value.data()}");
      } else {
        print("La banda no existe");
      }
    });
  }

  addDocumentFirebase() {
    bandCollection.add({
      'id': 6,
      'band': 'Metronomyssssss',
      'image':
          'https://studiosol-a.akamaihd.net/uploadfile/letras/fotos/3/6/7/f/367f472896e70c11cadc0efe791870c7.jpg',
      'status': true,
    }).then((value) {
      print("Banda agregada");
    }).catchError((error) {
      print("Hubo un error");
    });
  }

  addDocumentIdFirebase() {
    bandCollection.doc("MandarinaQW323").set({
      'id': 5,
      'band': 'Disturbed',
      'image':
          'https://www.todorock.com/wp-content/uploads/2019/09/disturbed-1200x900.jpeg',
      'status': true,
    }).then((value) {
      print("Banda agregada");
    }).catchError((error) {
      print("Hubo un error");
    });
  }

  updateDocumentFirebase() {
    bandCollection.doc("kqh8x0XMqjEbhCHsoi5g").update({
      'id': 6,
      'band': 'Belle and Sebastian',
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/1/19/Belle_and_Sebastian_British_Band.jpeg',
      'status': true,
    }).then((value) {
      print("Banda actualizada");
    }).catchError((error) {
      print("Hubo un error");
    });
  }

  deleteDocumentFirebase() {
    bandCollection.doc("nqQjo7gIDRvmQ2SReqIr").delete().then((value) {
      print("Banda eliminada");
    }).catchError((error) {
      print("Hubo un error al eliminar");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example"),
        actions: [
          IconButton(
            onPressed: () {
              getDocumentFirebase();
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //addDocumentFirebase();
          //addDocumentIdFirebase();
          //updateDocumentFirebase();
          deleteDocumentFirebase();
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: myBands.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 360,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(myBands[index]["image"]))),
            child: Center(
              child: Text(
                myBands[index]["band"],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                  letterSpacing: 10,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
