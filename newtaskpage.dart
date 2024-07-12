import 'package:hive/hive.dart';

part 'newtaskpage.g.dart';

@HiveType(typeId: 0)
class newtaskpage extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String des;

  @HiveField(2)
  String priority;

  @HiveField(3)
  DateTime dateandtime;

  @HiveField(4)
  bool? isCompleted;

  newtaskpage({
    required this.title,
    required this.des,
    required this.priority,
    required this.dateandtime,
    this.isCompleted=false
  });
}