import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as P;
import 'package:virtual_visiting_card/models/contact_model.dart';

class DbHelper {
  final String _createTableContact =
      '''create table $tableContact($tblContactColId INTEGER PRIMARY KEY AUTOINCREMENT,
  $tblContactColname TEXT,
  $tblContactColmobile TEXT,
  $tblContactColemail TEXT,
  $tblContactColaddress TEXT,
  
  $tblContactColCompany TEXT,
  $tblContactColdesignation TEXT,
  $tblContactColwebsite TEXT,
  $tblContactColimage TEXT,
  $tblContactColfavorite TEXT
  )''';
  Future<Database> _open() async {
    final root = await getDatabasesPath();
    final dbPath = P.join(root, 'contract_db');
    return openDatabase(
      dbPath,
      version: 3,
      onCreate: (db, version) {
        db.execute(_createTableContact);
      },
    );
  }

  Future<int> insertContact(ContactModel contactModel) async {
    final db = await _open();
    return db.insert(tableContact, contactModel.toMap());
  }

  Future<List<ContactModel>> getAllContact() async {
    final db = await _open();
    final mapList = await db.query(tableContact);
    return List.generate(
      mapList.length,
      (index) => ContactModel.fromMap(mapList[index]),
    );
  }
}
