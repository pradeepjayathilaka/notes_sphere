import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_sphere/utils/router.dart';
import 'package:note_sphere/utils/theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
