import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/screens/add_note_screen.dart';
import 'package:note_app/utils/firebase_services.dart';
import 'package:note_app/widgets/build_text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var colors = [
    const Color(0xffFEB4FF),
    const Color(0xfffe9e9f),
    const Color(0xff92f48f),
    const Color(0xfffff599),
    const Color(0xff9ffffe),
  ];
  bool isLoading = true;

  TextEditingController textEditingController = TextEditingController();
  List<NoteModel> notes = [];

  getData() async {
    notes = await FirebaseServices().getData();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff232323),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurpleAccent,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Text(
                    "Any Notes ?",
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        cursorColor: Colors.grey[500],
                        controller: textEditingController,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(9.0),
                            child: ImageIcon(
                              AssetImage("assets/search_outlined.png"),
                              color: Colors.white,
                            ),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 11),
                          filled: true,
                          fillColor: Colors.grey[800],
                          focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: SizedBox(
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: notes.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: MediaQuery.of(context)
                                    .size
                                    .width /
                                (MediaQuery.of(context).size.height / 1.525),
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 5),
                              child: SizedBox(
                                width: MediaQuery.sizeOf(context).width,
                                height: 300,
                                child: GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddNoteScreen(
                                        title: notes[index].title,
                                        body: notes[index].description,
                                        documentId: notes[index].documentId,
                                        date: DateFormat('dd MMMM yyyy').format(
                                          DateTime.parse(
                                            notes[index]
                                                .createdTime!
                                                .toDate()
                                                .toString(),
                                          ),
                                        ),
                                        isEdit: true,
                                      ),
                                    ),
                                  ),
                                  child: Card(
                                    color: colors[index % colors.length],
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: GridTile(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${notes[index].title!.length > 15 ? '${notes[index].title!.substring(0, 12)}...' : notes[index].title}',
                                              style: GoogleFonts.rajdhani(
                                                  fontSize: 25,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            const Spacer(),
                                            BuildTextWidget(
                                              text: notes[index]
                                                          .description!
                                                          .length >
                                                      85
                                                  ? '${notes[index].description!.substring(0, 82)}...'
                                                  : notes[index].description,
                                              color: Colors.black,
                                              size: 15,
                                              weight: FontWeight.w600,
                                            ),
                                            const Spacer(),
                                            BuildTextWidget(
                                              text: DateFormat('dd MMMM yyyy')
                                                  .format(
                                                DateTime.parse(
                                                  notes[index]
                                                      .createdTime!
                                                      .toDate()
                                                      .toString(),
                                                ),
                                              ),
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                              size: 15,
                                              weight: FontWeight.w600,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[800],
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNoteScreen(
                isEdit: false,
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
