import 'package:flutter_bloc/flutter_bloc.dart';

import '../note.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(NoteState(notes: [])) {
    on<AddNote>((event, emit) {
      final newNote = Note(
        title: event.title,
        category: event.category,
        content: event.description,
        createdAt: DateTime.now(),
      );

      final updatedNotes = List<Note>.from(state.notes)..add(newNote);
      emit(state.copyWith(notes: updatedNotes));
    });
    on<RemoveNote>((event, emit) {
      final removedNote = List<Note>.from(state.notes)..removeAt(event.index);
      emit(NoteState(notes: removedNote));
    });
  }
}
