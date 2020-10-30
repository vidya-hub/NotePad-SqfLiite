import 'package:NotePad/dbmodel.dart';
import 'package:NotePad/homepage.dart';
import 'package:flutter/material.dart';

class ContentWritng extends StatefulWidget {
  @override
  _ContentWritngState createState() => _ContentWritngState();
}

class _ContentWritngState extends State<ContentWritng> {
  var _controller = TextEditingController();
  Content contentModel;
  final DbHelper dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Material(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: TextField(
                      autocorrect: false,
                      controller: _controller,

                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        // contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        //  labelStyle: ,
                        labelText: "Enter the Content",
                      ),
                      // textAlign: TextAlign.center,
                      maxLines: 10,

                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    var currentData = Content(
                        content: _controller.text.trim(),
                        date: DateTime.now().toString());
                    dbHelper.insertData(currentData).then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return HomePage();
                          },
                        ),
                      );
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    child: const Text('Enter', style: TextStyle(fontSize: 20)),
                  ),
                ),
                // RaisedButton(
                //   onPressed: () {
                //     // var currentData = Content(
                //     //     content: _controller.text.trim(),
                //     //     date: DateTime.now().toString());
                //     // dbHelper.insertData(currentData).then((value) {
                //     //   Navigator.push(
                //     //     context,
                //     //     MaterialPageRoute(
                //     //       builder: (context) {
                //     //         return HomePage();
                //     //       },
                //     //     ),
                //     //   );
                //     // });
                //   },
                //   child: Text("Enter"),
                // ),
                // RaisedButton(
                //   onPressed: () {
                //     dbHelper.getAllTasks().then((value) {
                //       print(value);
                //     });
                //   },
                //   child: Text("Get the Data"),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
