import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_sphere/pages/home_page.dart';
import 'package:notes_sphere/pages/notes_by_category.dart';
import 'package:notes_sphere/pages/notes_page.dart';
import 'package:notes_sphere/pages/todo_page.dart';

class AppRouter {
  static final router = GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    debugLogDiagnostics: true,
    initialLocation: "/",
    routes: [
      GoRoute(
        //homepage
        name: "home",
        path: "/",
        builder: (context, state) {
          return HomePage();
        },
      ),
      GoRoute(
        name: "notes",
        path: "/notes",
        builder: (context, state) {
          return const NotesPage();
        },
      ),
      //todo page
      GoRoute(
        name: "todos",
        path: "/todos",
        builder: (context, state) {
          return const TodoPage();
        },
      ),
      //notes by category
      GoRoute(
        name: "category",
        path: "/category",
        builder: (context, state) {
          final String category = state.extra as String;
          return NotesByCategory(
            category: category,
          );
        },
      )
    ],
  );
}
