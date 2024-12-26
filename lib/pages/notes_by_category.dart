import 'package:flutter/material.dart';
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
                            removeNote: () async {
                              // Add remove note functionality here
                            },
                            editNote: () async {
                              // Add edit note functionality here
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
