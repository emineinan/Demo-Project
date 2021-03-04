import 'package:demo_project/model/item.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database _database;

  String _itemsTable = "items";
  String _columnID = "id";
  String _columnTodo = "todo";
  String _columnTime = "time";

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    String dbPath = join(await getDatabasesPath(), "items.db");
    var itemsDb = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return itemsDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(
        "Create table $_itemsTable($_columnID integer primary key, $_columnTodo text, $_columnTime text)");
  }

  //Crud Methods
  Future<List<Item>> getAllItems() async {
    Database db = await this.database;
    var result = await db.query("$_itemsTable");
    return List.generate(result.length, (i) {
      return Item.fromMap(result[i]);
    });
  }

  Future<int> insert(Item item) async {
    Database db = await this.database;
    var result = await db.insert("$_itemsTable", item.toMap());
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await this.database;
    var result = await db.rawDelete("delete from $_itemsTable where id=$id");
    return result;
  }

  Future<int> update(Item item) async {
    Database db = await this.database;
    var result = await db.update("$_itemsTable", item.toMap(),
        where: "id=?", whereArgs: [item.id]);
    return result;
  }
}
