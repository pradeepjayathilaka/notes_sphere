import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_sphere/helpers/snach_bar.dart';
import 'package:notes_sphere/models/note_model.dart';
import 'package:notes_sphere/services/note_service.dart';
import 'package:notes_sphere/utils/colors.dart';
import 'package:notes_sphere/utils/constants.dart';
import 'package:notes_sphere/utils/router.dart';
import 'package:notes_sphere/utils/text_styles.dart';
import 'package:uuid/uuid.dart';

class CreateNewNotePage extends StatefulWidget {
  final bool isNewCategory;
  const CreateNewNotePage({
    super.key,
    required this.isNewCategory,
  });

  @override
  State<CreateNewNotePage> createState() => _CreateNewNotePageState();
}

class _CreateNewNotePageState extends State<CreateNewNotePage> {
  List<String> categories = [];
  final NoteService _noteService = NoteService();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteContentController = TextEditingController();
  final TextEditingController _noteCategoryController = TextEditingController();
  String category = "";

  void dispose() {
    _noteTitleController.dispose();
    _noteCategoryController.dispose();
    _noteContentController.dispose();
    super.dispose();
  }

  Future _loadCategories() async {
    categories = await _noteService.getAllCategories();
    setState(() {});
  }

  @override
  void initState() {
    _loadCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Note",
          style: AppTextStyles.appSubtitle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            //dropdown
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: AppConstants.kDefaultPadding / 2,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    widget.isNewCategory
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              controller: _noteCategoryController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "please enter a category";
                                }
                                return null;
                              },
                              style: TextStyle(
                                color: AppColors.kWhiteColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                hintText: "New category",
                                hintStyle: TextStyle(
                                  color: AppColors.kWhiteColor.withOpacity(0.5),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  fontFamily: GoogleFonts.dmSans().fontFamily,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color:
                                        AppColors.kWhiteColor.withOpacity(0.1),
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: AppColors.kWhiteColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ))
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownButtonFormField<String>(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Select a Category ";
                                }
                                return null;
                              },
                              style: TextStyle(
                                color: AppColors.kWhiteColor,
                                fontFamily: GoogleFonts.dmSans().fontFamily,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                              isExpanded: false,
                              hint: const Text("category"),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color:
                                        AppColors.kWhiteColor.withOpacity(0.1),
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppConstants.kDefaultPadding),
                                  borderSide: BorderSide(
                                    color: AppColors.kWhiteColor,
                                    width: 1,
                                  ),
                                ),
                              ),
                              items: categories.map((String category) {
                                return DropdownMenuItem<String>(
                                  alignment: Alignment.centerLeft,
                                  value: category,
                                  child: Text(
                                    category,
                                    style: AppTextStyles.appButtonStyle,
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  category = value!;
                                });
                              },
                            ),
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    //title field
                    TextFormField(
                      controller: _noteTitleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter a Title ";
                        }
                        return null;
                      },
                      maxLines: 2,
                      style: TextStyle(
                        color: AppColors.kWhiteColor,
                        fontSize: 30,
                      ),
                      decoration: InputDecoration(
                        hintText: "Note Title",
                        hintStyle: TextStyle(
                          color: AppColors.kWhiteColor.withOpacity(0.5),
                          fontSize: 35,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //content field
                    TextFormField(
                      controller: _noteContentController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter your content ";
                        }
                        return null;
                      },
                      maxLines: 12,
                      style: TextStyle(
                        color: AppColors.kWhiteColor,
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        hintText: "Note Content",
                        hintStyle: TextStyle(
                          color: AppColors.kWhiteColor.withOpacity(0.5),
                          fontSize: 20,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    //button
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: AppColors.kWhiteColor.withOpacity(0.3),
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(AppColors.kFaBColor),
                          ),
                          onPressed: () {
                            //save the note
                            if (_formKey.currentState!.validate()) {
                              try {
                                _noteService.addNote(
                                  Note(
                                    title: _noteTitleController.text,
                                    category: widget.isNewCategory
                                        ? _noteCategoryController.text
                                        : category,
                                    content: _noteContentController.text,
                                    date: DateTime.now(),
                                    id: Uuid().v4(),
                                  ),
                                );
                                //snackbar
                                Apphelpers.showSanackBar(
                                    context, "Note saved Successfully");
                                _noteContentController.clear();
                                _noteTitleController.clear();
                                AppRouter.router.push("/notes");
                              } catch (err) {
                                print(err.toString());
                                Apphelpers.showSanackBar(
                                    context, "Failed to save note");
                              }
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Save Note",
                              style: AppTextStyles.appButtonStyle,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
