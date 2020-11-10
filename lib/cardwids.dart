
import 'package:NotePad/editnotes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardWIds extends StatelessWidget {
  CardWIds({
    @required this.notevalue,
  });
  var notevalue;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
