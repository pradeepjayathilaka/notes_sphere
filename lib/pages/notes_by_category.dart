import 'package:flutter/material.dart';
import 'package:notes_sphere/models/note_model.dart';
import 'package:notes_sphere/services/note_service.dart';

class NotesByCategory extends StatefulWidget {
  final String category;
  const NotesByCategory({
    super.key,
    required this.category,
  });

  @override
  State<NotesByCategory> createState() => _NotesByCategoryState();
}

class _NotesByCategoryState extends State<NotesByCategory> {
  final NoteService noteService = NoteService();
  List<Note> notelist = [];
  void initState() {
    super.initState();
    _loadNotesByCategory();
  }

  //load all notes by category
  Future<void> _loadNotesByCategory() async {
    notelist = await noteService.getNotesByCategoryName(widget.category);
    setState(() {
      print(notelist.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
    );
  }
}
