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

  TextEditingController _bandController = TextEditingController();
  TextEditingController _imageBandController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllDataFirebase();
  }

  getAllDataFirebase() {
    myBands.clear();
    bandCollection.orderBy('band', descending: true).get().then((value) {
      value.docs.forEach((element) {
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
      'id': myBands.length + 1,
      'band': _bandController.text,
      'image': _imageBandController.text,
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

  addShowDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text("Add band"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _bandController,
                decoration: InputDecoration(hintText: "Band"),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: _imageBandController,
                decoration: InputDecoration(hintText: "Image"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                addDocumentFirebase();
                _bandController.clear();
                _imageBandController.clear();
                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  deleteShowDialog({required String band}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete band"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Are you sure you want to delete...$band?")
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Delete",
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addShowDialog();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black87,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            getAllDataFirebase();
          },
          child: ListView.builder(
            itemCount: myBands.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onLongPress: () {
                  deleteShowDialog(band: myBands[index]["band"]);
                },
                child: Container(
                  height: 370,
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
