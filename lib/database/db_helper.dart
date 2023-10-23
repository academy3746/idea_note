import 'package:idea_note/data/db_class_info.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  late Database database;

  /// Initialize Database
  Future<void> initDataBase() async {
    // Get Database PATH
    String dbPath = join(await getDatabasesPath(), "idea_note.db");

    // Open Database
    database = await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) {
      // Execute Database
      db.execute("""
        CREATE TABLE IF NOT EXISTS tb_idea (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          motive TEXT,
          content TEXT,
          importance INTEGER,
          feedBack TEXT,
          regDate DATETIME
        )
      """);
    });
  }

  /// Insert Database (CREATE)
  Future<int> insertDatabase(IdeaInfo idea) async {
    return await database.insert("tb_idea", idea.toMap());
  }

  /// Select Database (READ)
  Future<List<IdeaInfo>> selectDatabase() async {
    final List<Map<String, dynamic>> result = await database.query("tb_idea");

    return List.generate(result.length, (index) {
      return IdeaInfo.fromMap(result[index]);
    });
  }

  /// Update Database (UPDATE)
  Future<int> updateDatabase(IdeaInfo idea) async {
    return await database.update(
      "tb_idea",
      idea.toMap(),
      where: "id = ?",
      whereArgs: [idea.id],
    );
  }

  /// Delete Database (DELETE)
  Future<int> deleteDatabase(int id) async {
    return await database.delete(
      "tb_idea",
      where: "id = ?",
      whereArgs: [id],
    );
  }

  /// Close Database: Prevent resources leak
  Future<void> closeDatabase() async {
    await database.close();
  }
}
