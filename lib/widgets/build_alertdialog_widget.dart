import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/screens/home_screen.dart';
import '../utils/firebase_services.dart';
import 'build_text_widget.dart';

showAlert({
  BuildContext? context,
  String? title,
  subTitle,
  command,
  noteTitle,
  noteDescription,
  documentId,
  Color? commandColor,
  commandBoxColor,
}) {
  showDialog<String>(
    context: context!,
    builder: (BuildContext context) => AlertDialog(
      title: BuildTextWidget(
        text: title,
        size: 20,
      ),
      backgroundColor: const Color(0xff232323),
      content: BuildTextWidget(
        text: subTitle,
        size: 16,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Cancel",
            style: GoogleFonts.rajdhani(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            if (command == 'Save') {
              FirebaseServices().addData(
                noteModel: NoteModel(
                  documentId: "",
                  createdTime: Timestamp.now(),
                  description: noteDescription,
                  title: noteTitle,
                ),
              );
            }
            if (command == 'Update') {
              FirebaseServices().updateData(
                docId: documentId,
                noteModel: NoteModel(
                  title: noteTitle,
                  description: noteDescription,
                ),
              );
            }
            if (command == 'Delete') {
              FirebaseServices().deleteData(docId: documentId);
            }
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          },
          child: Container(
            height: 45,
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: commandBoxColor ?? Colors.red,
            ),
            child: Center(
              child: Text(
                command,
                style: GoogleFonts.rajdhani(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: commandColor ?? Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
