import 'package:flutter/material.dart';
import 'package:notes_sphere/models/note_model.dart';
import 'package:notes_sphere/services/note_service.dart';
import 'package:notes_sphere/utils/colors.dart';
import 'package:notes_sphere/utils/constants.dart';
import 'package:notes_sphere/utils/router.dart';
import 'package:notes_sphere/utils/text_styles.dart';
import 'package:notes_sphere/widgets/notes_card.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final NoteService noteService = NoteService();
  List<Note> allNotes = [];
  Map<String, List<Note>> notesWithCategory = {};
  @override
  void initState() {
    super.initState();
    _checkAndCreateData();
  }

  //check weather the user is new
  void _checkAndCreateData() async {
    final bool isNewUser = await noteService.isNewUser();

    //if the user is new create the initial notes
    if (isNewUser) {
      await noteService.createdInitialNotes();
    }
    //load the notes
    _loadNotes();
  }

  //load the  notes function
  Future<void> _loadNotes() async {
    final List<Note> loadedNotes = await noteService.loadNotes();
    Map<String, List<Note>> notesByCategory =
        noteService.getNotesByCategoryMap(loadedNotes);
    setState(() {
      allNotes = loadedNotes;
      notesWithCategory = notesByCategory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              //go to the homepage
              AppRouter.router.go("/");
            },
            icon: Icon(Icons.arrow_back)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
            side: BorderSide(
              color: AppColors.kWhiteColor,
              width: 2,
            )),
        child: Icon(
          Icons.add,
          color: AppColors.kWhiteColor,
          size: 30,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(
          AppConstants.kDefaultPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Notes",
              style: AppTextStyles.appTitle,
            ),
            SizedBox(
              height: 30,
            ),
            allNotes.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Center(
                      child: Text(
                        "No Notes are available,please click the + button to add a new note",
                        style: AppTextStyles.appDescriptionLargeStyle,
                      ),
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: AppConstants.kDefaultPadding,
                      mainAxisSpacing: AppConstants.kDefaultPadding,
                      childAspectRatio: 6 / 4,
                    ),
                    itemCount: notesWithCategory.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          //go to the notes by category page
                          AppRouter.router.push(
                            "/category",
                            extra: notesWithCategory.keys.elementAt(index),
                          );
                        },
                        child: NotesCard(
                          noteCategory: notesWithCategory.keys.elementAt(index),
                          noOfNotes:
                              notesWithCategory.values.elementAt(index).length,
                        ),
                      );
                    },
                  )
          ],
        ),
      ),
    );
  }
}
