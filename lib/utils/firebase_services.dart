import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_app/models/note_model.dart';

class FirebaseServices {
  CollectionReference notes = FirebaseFirestore.instance.collection('notes');

  void addData({required NoteModel noteModel}) async {
    DocumentReference documentReference = await notes.add(noteModel.toJson());
    await notes
        .doc(documentReference.id)
        .update({"documentId": documentReference.id});
  }

  Future<List<NoteModel>> getData() async {
    var notes = await FirebaseFirestore.instance
        .collection('notes')
        .withConverter<NoteModel>(
          fromFirestore: (snapshot, options) =>
              NoteModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        )
        .get();
    List<NoteModel> responseData = [];
    for (var item in notes.docs) {
      responseData.add(item.data());
    }
    return responseData;
  }

  void updateData(
      {required String? docId, required NoteModel noteModel}) async {
    await notes.doc(docId).update({
      'title': noteModel.title,
      'description': noteModel.description,
    });
  }

  void deleteData({required String? docId}) async {
    await notes.doc(docId).delete();
  }
}
