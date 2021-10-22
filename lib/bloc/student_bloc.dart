import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sambast_sample/data/student.dart';
import 'package:sambast_sample/data/student_dao.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final StudentDao _studentDao = StudentDao();

  StudentBloc() : super(StudentsLoading());

  @override
  Stream<StudentState> mapEventToState(StudentEvent event) async* {
    if (event is LoadStudentsEvent) {
      yield* _loadStudents();
    } else if (event is AddStudentEvent) {
      yield* _addStudent(event);
    } else if (event is UpdateStudentEvent) {
      yield* _updateStudent(event);
    } else if (event is DeleteStudentEvent) {
      yield* _deleteStudent(event);
    }
  }

  Stream<StudentState> _loadStudents() async* {
    yield StudentsLoading();

    final students = await _studentDao.getAllSortedByName();

    yield StudentsLoaded(students);
  }

  Stream<StudentState> _addStudent(AddStudentEvent event) async* {
    await _studentDao.insert(event.newStudent);

    yield* _loadStudents();
  }

  Stream<StudentState> _updateStudent(UpdateStudentEvent event) async* {
    await _studentDao.update(student: event.newStudent, id: event.id);

    yield* _loadStudents();
  }

  Stream<StudentState> _deleteStudent(DeleteStudentEvent event) async* {
    await _studentDao.delete(event.id);

    yield* _loadStudents();
  }
}
