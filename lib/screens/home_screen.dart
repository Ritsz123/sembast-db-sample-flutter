import 'package:flutter/material.dart';
import 'package:sambast_sample/bloc/student_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sambast_sample/data/student.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late StudentBloc _studentBloc;
  String _name = "";
  String _age = "";

  @override
  void initState() {
    super.initState();
    _studentBloc = BlocProvider.of<StudentBloc>(context);
    _studentBloc.add(LoadStudentsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sembast sample'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          Student? newStudent = await _dialog();
          if (newStudent != null) {
            BlocProvider.of<StudentBloc>(context)
                .add(AddStudentEvent(newStudent));
          }
        },
      ),
      body: BlocBuilder<StudentBloc, StudentState>(
        builder: (context, state) {
          if (state is StudentsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StudentsLoaded) {
            return _buildBody(state);
          }
          return Container();
        },
      ),
    );
  }

  Future<Student?> _dialog() async {
    return await showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) => _name = value,
              decoration: const InputDecoration(
                hintText: "Enter Student name",
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              onChanged: (value) => _age = value,
              decoration: const InputDecoration(
                hintText: "Enter age",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(
                context,
                Student(name: _name, age: int.parse(_age)),
              ),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(StudentsLoaded state) {
    const textStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );

    final List<Student> studentList = state.students;

    return ListView.builder(
      itemCount: studentList.length,
      itemBuilder: (context, index) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(border: Border.all()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Id: ${studentList[index].id}',
              style: textStyle.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              'Name: ${studentList[index].name}',
              style: textStyle.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              'Age: ${studentList[index].age}',
              style: textStyle.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
