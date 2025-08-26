// lib/bloc/note_state.dart
import '../note.dart';

class NoteState {
  final List<Note> notes;

  NoteState({this.notes = const []});

  NoteState copyWith({List<Note>? notes}) {
    return NoteState(
      notes: notes ?? this.notes,
    );
  }
}
