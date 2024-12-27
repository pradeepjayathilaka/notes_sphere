import 'package:flutter/material.dart';
import 'package:notes_sphere/helpers/snach_bar.dart';
import 'package:notes_sphere/models/note_model.dart';
import 'package:notes_sphere/services/note_service.dart';
import 'package:notes_sphere/utils/constants.dart';
import 'package:notes_sphere/utils/router.dart';
import 'package:notes_sphere/utils/text_styles.dart';
import 'package:notes_sphere/widgets/note_category_card.dart';

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

  @override
  void initState() {
    super.initState();
    _loadNotesByCategory();
  }

  // Load all notes by category
  Future<void> _loadNotesByCategory() async {
    final List<Note> loadedNotes =
        await noteService.getNotesByCategoryName(widget.category);
    setState(() {
      notelist = loadedNotes;
    });
  }

  //edit note
  void _editNote(Note note) {
    //navigate to the edit notepage
    AppRouter.router.push("/edit-note", extra: note);
  }

  //remove note
  Future<void> _removeNote(String id) async {
    try {
      await noteService.deleteNote(id);
      if (context.mounted) {
        Apphelpers.showSanackBar(context, "Note deleted Successfully");
      }
    } catch (error) {
      Apphelpers.showSanackBar(context, "Failed to delete note ");
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            // Go back to the notes page
            AppRouter.router.push("/notes");
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.kDefaultPadding,
          ),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Text(
                widget.category,
                style: AppTextStyles.appTitle,
              ),
              const SizedBox(height: 30),
              // Wrap GridView.builder in SizedBox or Constrained Box
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: notelist.isEmpty
                    ? Center(
                        child: Text(
                          "No notes found in this category",
                          style: AppTextStyles.appdescriptionSmallStyle,
                        ),
                      )
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: AppConstants.kDefaultPadding,
                          mainAxisSpacing: AppConstants.kDefaultPadding,
                          childAspectRatio: 7 / 11,
                        ),
                        itemCount: notelist.length,
                        itemBuilder: (context, index) {
                          return NoteCategoryCard(
                            notTitle: notelist[index].title,
                            notContent: notelist[index].content,
                            editNote: () async {
                              // Add edit note functionality here
                              _editNote(notelist[index]);
                            },
                            removeNote: () async {
                              // Add remove note functionality here
                              await _removeNote(notelist[index].id);
                              setState(() {
                                notelist.removeAt(index);
                              });
                            },
                            viewSingleNote: () {
                              AppRouter.router.push(
                                "/single-note",
                                extra: notelist[index],
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
