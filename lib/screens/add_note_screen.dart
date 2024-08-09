import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../widgets/build_alertdialog_widget.dart';

class AddNoteScreen extends StatefulWidget {
  final String? title;
  final String? body;
  final bool? isEdit;
  final String? documentId;
  final String? date;

  const AddNoteScreen({
    super.key,
    this.title,
    this.body,
    this.isEdit,
    this.documentId,
    this.date,
  });

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  String dateTime = DateFormat('dd MMMM yyyy').format(
    DateTime.parse(
      DateTime.now().toString(),
    ),
  );

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  bool isShowDelete = false;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    check();
  }

  check() {
    titleController = TextEditingController(text: widget.title);
    bodyController = TextEditingController(text: widget.body);

    if (widget.isEdit == true) {
      setState(() {
        isShowDelete = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff232323),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    children: [
                      isShowDelete
                          ? IconButton(
                              onPressed: () {
                                showAlert(
                                  context: context,
                                  title: "Delete note ?",
                                  subTitle:
                                      "Are you sure you want to delete this note ?",
                                  command: "Delete",
                                  documentId: widget.documentId,
                                );
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.grey,
                              ),
                            )
                          : const SizedBox(),
                      IconButton(
                        onPressed: () {
                          isShowDelete
                              ? showAlert(
                                  context: context,
                                  title: "Edit note ?",
                                  subTitle:
                                      "Are you sure you want to save this note ?",
                                  command: "Update",
                                  commandColor: Colors.black,
                                  commandBoxColor: Colors.white,
                                  noteTitle: titleController.text,
                                  noteDescription: bodyController.text,
                                  documentId: widget.documentId,
                                )
                              : showAlert(
                                  context: context,
                                  title: "Save note ?",
                                  subTitle:
                                      "Are you sure you want to save this note ?",
                                  command: "Save",
                                  commandColor: Colors.black,
                                  commandBoxColor: Colors.white,
                                  noteTitle: titleController.text,
                                  noteDescription: bodyController.text,
                                );
                        },
                        icon: const Icon(
                          Icons.check,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 70,
              ),
              TextFormField(
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                cursorColor: Colors.white.withOpacity(0.2),
                style: GoogleFonts.rajdhani(
                  fontSize: 70,
                  color: Colors.white,
                ),
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: GoogleFonts.gruppo(
                    fontSize: 70,
                    color: Colors.grey[700],
                  ),
                  border: InputBorder.none,
                ),
              ),
              Text(
                isShowDelete ? widget.date! : dateTime,
                style: GoogleFonts.sairaCondensed(
                    fontSize: 23,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  cursorHeight: 45,
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  textAlignVertical: TextAlignVertical.center,
                  cursorColor: Colors.white.withOpacity(0.3),
                  style: GoogleFonts.rajdhani(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                  controller: bodyController,
                  decoration: InputDecoration(
                    hintText: "Description",
                    hintStyle: GoogleFonts.gruppo(
                      fontSize: 40,
                      color: Colors.grey[700],
                    ),
                    border: InputBorder.none,
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
