part of 'student_bloc.dart';

abstract class StudentEvent extends Equatable {
  const StudentEvent();
}

class LoadStudentsEvent extends StudentEvent {
  @override
  List<Object> get props => [];
}

class AddStudentEvent extends StudentEvent {
  final Student newStudent;

  const AddStudentEvent(this.newStudent);

  @override
  List<Object> get props => [newStudent];
}

class UpdateStudentEvent extends StudentEvent {
  final Student newStudent;
  final int id;

  const UpdateStudentEvent({required this.newStudent, required this.id});

  @override
  List<Object> get props => [id, newStudent];
}

class DeleteStudentEvent extends StudentEvent {
  final int id;

  const DeleteStudentEvent(this.id);

  @override
  List<Object> get props => [id];
}
