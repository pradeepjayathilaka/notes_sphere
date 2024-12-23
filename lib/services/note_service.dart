import 'package:hive_flutter/adapters.dart';
import 'package:notes_sphere/models/note_model.dart';
import 'package:uuid/uuid.dart';

class NoteService {
  List<Note> allNotes = [
    Note(
      id: const Uuid().v4(),
      title: "Meeting Notes",
      category: "Work",
      content:
          "Discuss project deadline and deliverables tasks to team members and setup follow_up meeting track progress",
      date: DateTime.now(),
    ),
    Note(
      id: const Uuid().v4(),
      title: "Grocery List",
      category: "personal",
      content:
          "Bought milk,eggs,bread,fruits, and vegetables from the local grocery store.Also Added some snacks for the week",
      date: DateTime.now(),
    ),
    Note(
      id: const Uuid().v4(),
      title: "Book reconmendations",
      category: "Hobby",
      content:
          "Recently read 'Sapiens' by tuval Noah Marari,which offered fascinating insights into the history of humankind .Also enjoyed 'Atomic Habits' by james Clear,a practical guide to building  good habits and breaking bad ones",
      date: DateTime.now(),
    )
  ];
  //Create the database reference for notes
  final _myBox = Hive.box("notes");

  //check weather the user is new user
  Future<bool> isNewUser() async {
    return _myBox.isEmpty;
  }

  //Method to craete the initial notes if the box is empty
  Future<void> createdInitialNotes() async {
    if (_myBox.isEmpty) {
      await _myBox.put("notes", allNotes);
    }
  }

  //Method to load all notes
  Future<List<Note>> loadNotes() async {
    final dynamic notes = _myBox.get("notes");
    if (notes != null && notes is List<dynamic>) {
      return notes.cast<Note>().toList();
    }
    return [];
  }

  //loop throught all notes and create an object where the key is the category and the value is the notes in that category
  Map<String, List<Note>> getNotesByCategoryMap(List<Note> allNotes) {
    final Map<String, List<Note>> notesBycategory = {};
    for (final note in allNotes) {
      if (notesBycategory.containsKey(note.category)) {
        notesBycategory[note.category]!.add(note);
      } else {
        notesBycategory[note.category] = [note];
      }
    }
    return notesBycategory;
  }

  //method to get the notes according to the category
  Future<List<Note>> getNotesByCategoryName(String category) async {
    final dynamic allNotes = await _myBox.get("notes");
    final List<Note> notes = [];

    for (final note in allNotes) {
      if (note.category == category) {
        notes.add(note);
      }
    }
    return notes;
  }
}
