import 'package:sembast/sembast.dart';
import 'app_database.dart';
import 'student.dart';

class StudentDao {
  static const String STUDENT_STORE = 'students';

  final _studentStore = intMapStoreFactory.store(STUDENT_STORE);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Student student) async {
    await _studentStore.add(await _db, student.toJson());
  }

  Future update({required Student student, required int id}) async {
    final finder = Finder(filter: Filter.byKey(id));

    await _studentStore.update(
      await _db,
      student.toJson(),
      finder: finder,
    );
  }

  Future delete(int id) async {
    final finder = Finder(filter: Filter.byKey(id));

    await _studentStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<Student>> getAllSortedByName() async {
    final finder = Finder(
      sortOrders: [SortOrder('name')],
    );

    final recordSnapshots = await _studentStore.find(
      await _db,
      finder: finder,
    );

    return recordSnapshots
        .map((snapshot) => Student.fromJson(snapshot.value)..id = snapshot.key)
        .toList();
  }
}
