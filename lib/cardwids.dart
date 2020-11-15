import 'package:NotePad/editnotes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardWIds extends StatelessWidget {
  CardWIds({
    @required this.notevalue,
  });
  var notevalue;
  String dateModifier(String reqDate) {
    List reqDateList = reqDate.split(":");
    String finalDate = "${reqDateList[0]}-${reqDateList[1]}";
    // print(reqDateList[0]);
    // print(finalDate);
    return finalDate;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        dateModifier(
            DateFormat("yyyy-MM-dd hh:mm").parse(notevalue["date"]).toString());
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
          color: Color.fromRGBO(20, 33, 48, 1),
          elevation: 5,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color.fromRGBO(24, 26, 39, 1), width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
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
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70),
                  ),
                  Text(
                      dateModifier(DateFormat("yyyy-MM-dd hh:mm")
                          .parse(notevalue["date"])
                          .toString()),
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
