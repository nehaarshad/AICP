import 'package:hive/hive.dart';
import 'package:to_do_list_application/newtaskpage.dart';

class Boxes{
  static Box<newtaskpage> getData() => Hive.box<newtaskpage>('todolist');
}