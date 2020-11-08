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
        // setState(() {
        //   notesCards.clear();
        // });
      });
    });
  }

  void initState() {
    setState(() {
      getData();
      // notesCards.clear();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text("NOTEPAD")),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 30,
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ContentWritng();
          }));
        },
      ),
      body: Container(
        child: notesCards.length == 0
            ? Center(child: EmptyCards())
            : GridView.builder(
                itemCount: notesCards.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  var item = notesCards[index];
                  return Dismissible(
                    key: ValueKey(item),
                    onDismissed: (direction) {
                      setState(() {
                        notesCards.removeAt(index);
                        dbHelper.deleteData(notesList[index]["id"]);

                      });
                    },
                    child: notesCards[index],
                  );
                },
              ),
      ),
    );
  }
}

class CardWIds extends StatelessWidget {
  CardWIds({
    @required this.notevalue,
  });

  var notevalue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // print(notesValues[index]["id"]);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return EditNotes(
                initialvalue: notevalue,
              );
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    notevalue["content"].toString().length >= 40
                        ? notevalue["content"].toString().substring(0, 10) +
                            "............"
                        : notevalue["content"],
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(DateFormat("yyyy-MM-dd hh:mm")
                      .parse(notevalue["date"])
                      .toString())
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
