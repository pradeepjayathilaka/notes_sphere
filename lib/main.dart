import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:notes_sphere/models/note_model.dart';
import 'package:notes_sphere/models/todo_model.dart';

import 'package:notes_sphere/utils/router.dart';
import 'package:notes_sphere/utils/theme_data.dart';

void main() async {
  //initialize hive
  await Hive.initFlutter();
  //register adapter
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(TodoAdapter());

  //open box
  await Hive.openBox('notes');
  await Hive.openBox('todos');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "NoteSphere",
      debugShowCheckedModeBanner: false,
      theme: ThemeClass.darkTheme.copyWith(
        textTheme: GoogleFonts.dmSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      routerConfig: AppRouter.router,
    );
  }
}
