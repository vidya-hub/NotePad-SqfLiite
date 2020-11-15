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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                            color: Color.fromRGBO(92, 0, 255, 1),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                  ),
                  GestureDetector(
                    onTap: () {
                      var currentData = Content(
                          content: _controller.text.trim(),
                          date: DateTime.now().toString());
                      dbHelper.insertData(currentData).then((value) {
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
              Container(
                // height: MediaQuery.of(context).size.height,
                child: Material(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                autocorrect: true,
                                cursorColor: Color.fromRGBO(92, 0, 255, 1),
                                controller: _controller,

                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  // contentPadding: EdgeInsets.symmetric(horizontal: 20),
                                  //  labelStyle: ,
                                  // labelText: "Enter the Content",
                                ),
                                // textAlign: TextAlign.center,
                                maxLines: 35,
                                toolbarOptions: ToolbarOptions(
                                  cut: true,
                                  copy: true,
                                  selectAll: true,
                                  paste: true,
                                ),
                                style: TextStyle(
                                    color: Color.fromRGBO(92, 0, 255, 1),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
