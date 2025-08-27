import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Your existing imports
import '../data/bloc/note_bloc.dart';
import '../data/bloc/note_event.dart';
import '../data/bloc/note_state.dart';
import '../data/note.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NoteBloc>().add(LoadNotes());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

          appBar: AppBar(
            title: const Text("Cozy Notes"),
            centerTitle: true,
          ),
          body: BlocBuilder<NoteBloc, NoteState>(
            builder: (context, state) {
              if (state.notes.isEmpty) {
                return const Center(child: Text("No notes yet. Add some!"));
              }

              return GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemCount: state.notes.length,
                itemBuilder: (context, index) {
                  final note = state.notes[index];
                  return Draggable<int>(
                    data: index,
                    feedback: Material(
                      color: Colors.transparent,
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: _buildNoteCard(note),
                      ),
                    ),
                    childWhenDragging: Opacity(
                      opacity: 0.5,
                      child: _buildNoteCard(note),
                    ),
                    child: _buildNoteCard(note),
                  );
                },
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              _showAddNoteBottomSheet(context);
            },
          ),
        ),

        // 📌 Delete Zone overlay that covers EVERYTHING (including AppBar)
        Positioned.fill(
          child: IgnorePointer(
            ignoring: false,
            child: Align(
              alignment: Alignment.centerRight,
              child: DragTarget<int>(
                builder: (context, candidateData, rejectedData) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        gradient: candidateData.isNotEmpty
                            ? LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Colors.red.withOpacity(0.01),
                                  Colors.red.withOpacity(0.4),
                                ],
                              )
                            : null,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.delete_forever,
                          size: 50,
                          color: candidateData.isNotEmpty
                              ? Colors.white.withOpacity(0.9)
                              : Colors.transparent,
                        ),
                      ),
                    ),
                  );
                },
                onWillAccept: (data) => data != null,
                onAccept: (index) {
                  context.read<NoteBloc>().add(RemoveNote(index));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Note deleted")),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 📌 Note Card UI
  Widget _buildNoteCard(Note note) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: note.color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            note.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              note.content,
              style: const TextStyle(fontSize: 14),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                note.category,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                "${note.createdAt.day}/${note.createdAt.month}",
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 📌 Bottom Sheet to add new note
  void _showAddNoteBottomSheet(BuildContext context) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    final categoryController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: contentController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Content",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(
                  labelText: "Category",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (titleController.text.isNotEmpty &&
                      contentController.text.isNotEmpty &&
                      categoryController.text.isNotEmpty) {
                    context.read<NoteBloc>().add(
                          AddNote(
                            titleController.text,
                            contentController.text,
                            categoryController.text,
                          ),
                        );
                    Navigator.pop(context);
                  }
                },
                child: const Text("Add Note"),
              ),
            ],
          ),
        );
      },
    );
  }
}
