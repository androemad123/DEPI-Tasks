import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'features/home/ui/base_home_screen.dart';
import 'features/notes/data/bloc/note_bloc.dart';
import 'features/to do list/data/todo_provider.dart';

void main() {
  runApp(const DepiTasks());
}

class DepiTasks extends StatelessWidget {
  const DepiTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()), // still keep your TodoProvider
        BlocProvider(create: (_) => NoteBloc()),               // add your NoteBloc
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Depi Tasks',
        home: HomeScreen(), // you can navigate to NotesListScreen from here
      ),
    );
  }
}
