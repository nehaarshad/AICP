import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_do_list_application/welcomepage.dart';
import 'newtaskpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  await Hive.initFlutter();

  Hive.registerAdapter(newtaskpageAdapter());
  await Hive.openBox<newtaskpage>("todolist");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TO_DO_LIST Application',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const welcomepage(),
      routes: {
        '/welcomepage': (context) => const welcomepage(),
      },
    );
  }
}

