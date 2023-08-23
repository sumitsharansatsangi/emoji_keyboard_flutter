import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'emoji.dart';

/// The storage. This holds all the components of the local db.
/// Here we will be able to:
/// - initialize the database
/// - create a new Emoji table, if none exist yet.
/// - get all entries in the emoji table.
/// - add a emoji emoji entry in the db.
/// - update an existing emoji entry to increase the count.
class Storage {

  static final Storage _instance = Storage._internal();

  Isar? isar;

  factory Storage() {
    return _instance;
  }

  Storage._internal();

  Future<Isar?> get database async {
    if (isar != null) return isar;
    final dir = await getApplicationSupportDirectory();
    isar = await Isar.open([
      EmojiSchema,
    ], directory: dir.path, inspector: false);
    return isar;
  }

  Future<List<Emoji>> fetchAllEmojis() async {
    Isar? isar = await this.database;
    if (isar != null) return await isar.emojis.where().findAll();
    return List.empty();
  }

  Future<int> addEmoji(Emoji emoji) async {
    Isar? isar = await this.database;
   return await isar!.writeTxn<int>(() async {
    return await isar.emojis.put(emoji);
   });
  }
}
