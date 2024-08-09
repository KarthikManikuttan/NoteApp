import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

NoteModel noteModelFromJson(String str) => NoteModel.fromJson(json.decode(str));

String noteModelToJson(NoteModel data) => json.encode(data.toJson());

class NoteModel {
  final String? title;
  final String? description;
  final Timestamp? createdTime;
  final String? documentId;

  NoteModel({
    this.title,
    this.description,
    this.createdTime,
    this.documentId,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
    title: json["title"],
    description: json["description"],
    createdTime: json["createdTime"],
    documentId: json["documentId"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "createdTime": createdTime,
    "documentId": documentId,
  };
}
