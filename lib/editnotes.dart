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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.13,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) {
                              return HomePage();
                            },
                          ),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: Color.fromRGBO(92, 0, 255, 1),
                        radius: 18,
                        child: CircleAvatar(
                            radius: 15,
                            foregroundColor: Color.fromRGBO(92, 0, 255, 1),
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              size: 25,
                            )),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                    ),
                    GestureDetector(
                      onTap: () {
                        print(widget.initialvalue);
                        Content updatedData = Content(
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
                                fullscreenDialog: true,
                                builder: (context) {
                                  return HomePage();
                                },
                              ),
                            );
                          });
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: Color.fromRGBO(92, 0, 255, 1),
                        radius: 18,
                        child: CircleAvatar(
                            radius: 15,
                            foregroundColor: Color.fromRGBO(92, 0, 255, 1),
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.check,
                              color: Color.fromRGBO(92, 0, 255, 1),
                              size: 25,
                            )),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    // elevation: 9,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        cursorColor: Color.fromRGBO(92, 0, 255, 1),

                        maxLines: 35,
                        toolbarOptions: ToolbarOptions(
                          cut: true,
                          copy: true,
                          selectAll: true,
                          paste: true,
                        ),
                        autofocus: true,
                        controller: controller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(92, 0, 255, 1),
                            fontWeight: FontWeight.bold),
                        // maxLines: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
