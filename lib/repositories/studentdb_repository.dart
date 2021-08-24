import 'package:cadastro_de_alunos/models/student.dart';
import 'package:cadastro_de_alunos/models/db_local.dart';
import 'package:cadastro_de_alunos/repositories/student_repository.dart';
import 'package:sqflite/sqlite_api.dart';

class StudentDBRepository implements StudentRepository{
  @override
  late DBLocal dbLocal;

  StudentRepository() {
    this.dbLocal = DBLocal(table: 'students');
  }

  @override
  Future<Student> find(int id) async{
    Database database = await dbLocal.getConnection();
    List<Map<String, dynamic>> data = await database.query(
      dbLocal.table,
      where: 'id=?',
      whereArgs: [id],
    );
    database.close();
    return Student.fromMap(data.first);
  }

  @override
  Future<int> insert(Student entity) async{
    Database database = await dbLocal.getConnection();
    var id =  await database.insert(
      dbLocal.table, 
      entity.toMap(),
    );
    database.close();
    return id;
  }

  @override
  Future<int> remove({required String conditions, required List conditionsValue}) async{
    Database database = await dbLocal.getConnection();
    var id = await database.delete(
      dbLocal.table,
      where: conditions,
      whereArgs: conditionsValue,
    );
    database.close();
    return id;
  }

  @override
  Future<List<Student>> search() async{
    Database database = await dbLocal.getConnection();
    var data = await database.query(dbLocal.table);
    var students = data.map((e) => Student.fromMap(e)).toList();
    database.close();
    return students;
  }

  @override
  Future<int> update({required Student entity, required String conditions, required List conditionsValue}) async{
    Database database = await dbLocal.getConnection();
    var id = database.update(
      dbLocal.table, 
      entity.toMap(),
      where: conditions,
      whereArgs: conditionsValue,
    ); 
    database.close();
    return id;
  }

}