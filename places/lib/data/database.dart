import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class Database {
  static Future<void> _init(sql.Database db, int version) async {
    return db.execute('''
create table places
(
  id       text primary key,
 title     text,
 image     text,
 latitude  double,
 longitude double,
 address   text
)
''');
  }

  static Future<sql.Database> _open() async {
    return await sql.openDatabase(
      path.join(
        await sql.getDatabasesPath(),
        "places.db",
      ),
      onCreate: _init,
      version: 1,
    );
  }

  static Future<List<Map<String, dynamic>>> select(String table) async {
    final db = await _open();
    try {
      return await db.query(table);
    } finally {
      await db.close();
    }
  }

  static Future<void> insert(
    String table,
    Map<String, dynamic> data,
  ) async {
    final db = await _open();
    try {
      await db.insert(
        table,
        data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace,
      );
    } finally {
      await db.close();
    }
  }
}
