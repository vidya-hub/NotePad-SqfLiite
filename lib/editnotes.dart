import 'package:NotePad/homepage.dart';
import 'package:flutter/material.dart';

import 'dbmodel.dart';

class EditNotes extends StatefulWidget {
  var initialvalue;
  EditNotes({@required this.initialvalue});

  @override
  _EditNotesState createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  TextEditingController controller;
  @override
  void initState() {
    super.initState();
    setState(() {
      controller = TextEditingController(
          text: widget.initialvalue["content"].toString());
    });
  }

  final DbHelper dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  // elevation: 9,
                  child: TextFormField(
                    autocorrect: false,
                    autofocus: true,
                    controller: controller,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blueAccent, fontWeight: FontWeight.bold),
                    maxLines: 10,
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  print(widget.initialvalue);
                  Content updatedData = Content(
                      // id: ,
                      content: controller.text.trim(),
                      id: widget.initialvalue["id"],
                      date: DateTime.now().toString());
                  print(updatedData.id);
                  dbHelper.initDatabase().then((value) {
                    dbHelper.updateData(updatedData).then((value) {
                      print(value);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return HomePage();
                          },
                        ),
                      );
                    });
                  });
                },
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF0D47A1),
                          Color(0xFF1976D2),
                          Color(0xFF42A5F5),
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(80.0))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                  child: const Text('UpDate', style: TextStyle(fontSize: 20)),
                ),
              ),
              // RaisedButton(
              //   onPressed: () {

              //   },
              //   child: Text("UpDate"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
