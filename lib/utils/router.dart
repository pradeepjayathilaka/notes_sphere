import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_sphere/models/note_model.dart';
import 'package:notes_sphere/pages/create_new_note.dart';
import 'package:notes_sphere/pages/home_page.dart';
import 'package:notes_sphere/pages/notes_by_category.dart';
import 'package:notes_sphere/pages/notes_page.dart';
import 'package:notes_sphere/pages/todo_page.dart';
import 'package:notes_sphere/pages/upadte_note_page.dart';

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
      ),
      //create new note
      GoRoute(
        name: "create new note",
        path: "/create-note",
        builder: (context, state) {
          final isNewCategoryPage = state.extra as bool;
          return CreateNewNotePage(
            isNewCategory: isNewCategoryPage,
          );
        },
      ),
      //edit page
      GoRoute(
        name: "edit note",
        path: "/edit-note",
        builder: (context, state) {
          final Note note = state.extra as Note;
          return UpadteNotePage(
            note: note,
          );
        },
      )
    ],
  );
}
