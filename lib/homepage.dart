import 'package:NotePad/cardwids.dart';
import 'package:NotePad/content.dart';
import 'package:NotePad/dbmodel.dart';
import 'package:NotePad/editnotes.dart';
import 'package:NotePad/emptyCards.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Content contentModel;
  final DbHelper dbHelper = DbHelper();
  List notesList = [];
  List<Widget> notesCards = [];

  getData() {
    dbHelper.initDatabase().then((value) {
      dbHelper.getAllTasks().then((value) {
        setState(() {
          notesList = value;
          notesCards.clear();
          // notesList=List.from(notesList.reversed);
        });
        for (var notesValue in notesList) {
          setState(() {
            notesCards.add(CardWIds(notevalue: notesValue));
          });
        }
      });
    });
  }

  void initState() {
    setState(() {
      getData();
      // notesCards.clear();
    });
    // timerValues();
    super.initState();
  }

  timerValues(int index) {
    setState(() {
      deletion = true;
    });
    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        // notesCards.removeAt(index);
        if (deletion == true) {
          dbHelper.deleteData(notesList[index]["id"]);
          getData();
        }
        deletion = false;
      });
    });
    // print("Completed");
    // return Null;
  }

  bool deletion = false;
  Map<int, Widget> deletedCard = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(15, 26, 39, 1),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(92, 0, 255, 1),
        child: Icon(
          Icons.add,
          size: 30,
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) {
                    return ContentWritng();
                  }));
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05,
                        vertical: MediaQuery.of(context).size.height * 0.03),
                    child: Text(
                      "Notes",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 45,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height / 8,
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      child: notesCards.length == 0
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                EmptyCards(),
                              ],
                            )
                          : GridView.builder(
                              itemCount: notesCards.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: (BuildContext context, int index) {
                                var item = notesCards[index];
                                return Dismissible(
                                  key: ValueKey(item),
                                  onDismissed: (direction) {
                                    setState(() {
                                      deletedCard.clear();
                                      deletedCard[index] = notesCards[index];
                                      notesCards.removeAt(index);
                                      // dbHelper.deleteData(notesList[index]["id"]);
                                      // getData();
                                    });
                                    timerValues(index);
                                  },
                                  child: notesCards[index],
                                );
                              },
                            ),
                    ),
                    // SizedBox(height: MediaQuery.of(context).size.height/2,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          alignment: Alignment.bottomCenter,
                          // padding: EdgeInsets.symmetric(vertical:90),
                          child: deletion
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 50, horizontal: 80),
                                  child: Card(
                                    color: Color.fromRGBO(20, 33, 48, 1),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Color.fromRGBO(24, 26, 39, 1),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    elevation: 2,
                                    borderOnForeground: true,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "Deleting.......",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white38),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                deletion = false;
                                                notesCards.insert(
                                                    deletedCard.keys.single,
                                                    deletedCard.values.single);
                                                getData();
                                              });
                                            },
                                            child: Text(
                                              "Undo",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.blue),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
