import 'package:isar/isar.dart';
part 'emoji.g.dart';

@Collection()
class Emoji {
  Id? id;
  @Index(unique: true, replace:true)
  late String emoji;
  late int amount;

  increase() {
    this.amount += 1;
  }
}
