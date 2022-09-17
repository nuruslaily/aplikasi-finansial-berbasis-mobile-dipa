import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
    static Future<void> createTables(sql.Database database) async {
        await database.execute("""
        CREATE TABLE transaksi(
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
            name TEXT,
            tanggal TEXT,
            nominal INT,
            keterangan TEXT
        )""");
    }

    static Future<sql.Database> db() async {
        return sql.openDatabase('transaksi.db', version: 1, 
            onCreate: (sql.Database database, int version) async {
                await createTables(database);
        });
    }

    static Future<int> tambahData(String name, String tanggal, String nominal, String keterangan) async {
      // print(tanggal);
        final db = await SQLHelper.db();
        final data = {'name': name, 'tanggal': tanggal, 'nominal': int.parse(nominal), 'keterangan': keterangan};
        return await db.insert('transaksi', data);
    }

    static Future<List<Map<String, dynamic>>> ambilData() async {
        final db = await SQLHelper.db();
        return db.query('transaksi');
    }
 
}