import 'package:NotePad/dbmodel.dart';
import 'package:NotePad/homepage.dart';
import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

void main() async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyHome(),
  ));
  WidgetsFlutterBinding.ensureInitialized();
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  getData() {
    dbHelper.initDatabase().then((value) {
      dbHelper.getAllTasks().then((value) {
        setState(() {
          notesValues = value;
        });
      });
    });
  }

  List notesValues = [];
  Content contentModel;
  final DbHelper dbHelper = DbHelper();
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}
