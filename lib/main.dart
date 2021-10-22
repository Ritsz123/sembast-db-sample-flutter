import 'package:flutter/material.dart';
import 'package:sambast_sample/bloc/student_bloc.dart';
import 'package:sambast_sample/screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentBloc(),
      child: MaterialApp(
        title: 'sembast sample',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
