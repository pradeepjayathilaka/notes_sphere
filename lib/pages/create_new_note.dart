import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_sphere/services/note_service.dart';
import 'package:notes_sphere/utils/colors.dart';
import 'package:notes_sphere/utils/constants.dart';
import 'package:notes_sphere/utils/text_styles.dart';

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
  String category = 'Work';
  List<String> categories = [];
  final NoteService _noteService = NoteService();

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
                child: Column(
                  children: [
                    widget.isNewCategory
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
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
                            child: DropdownButtonFormField(
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
                              onChanged: (value) {},
                            ),
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    //title field
                    TextFormField(
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
                      maxLines: 8,
                      style: TextStyle(
                        color: AppColors.kWhiteColor,
                        fontSize: 30,
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
                          onPressed: () {},
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
