import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../note.dart';
import '../notes_database.dart'; // import DB
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NotesDatabase db = NotesDatabase.instance;

  Color _randomNoteColor() {
    final random = Random();
    final baseColors = [
      Colors.pink.shade100,
      Colors.blue.shade100,
      Colors.green.shade100,
      Colors.orange.shade100,
      Colors.purple.shade100,
      Colors.teal.shade100,
      Colors.yellow.shade100,
    ];
    return baseColors[random.nextInt(baseColors.length)];
  }

  NoteBloc() : super(NoteState(notes: [])) {
    // Load all notes on startup
    on<LoadNotes>((event, emit) async {
      final notes = await db.readAllNotes();
      emit(NoteState(notes: notes));
    });

    on<AddNote>((event, emit) async {
      final newNote = Note(
        id: DateTime.now().millisecondsSinceEpoch,
        color: _randomNoteColor(),
        title: event.title,
        category: event.category,
        content: event.description,
        createdAt: DateTime.now(),
      );

      await db.create(newNote);
      final notes = await db.readAllNotes();
      emit(NoteState(notes: notes));
    });

    on<RemoveNote>((event, emit) async {
      final noteToDelete = state.notes[event.index];
      await db.delete(noteToDelete.id);
      final notes = await db.readAllNotes();
      emit(NoteState(notes: notes));
    });
  }
}
