import 'package:flutter/material.dart';
import 'routes/routes.dart';
import 'package:boi_system/widgets/drawer.dart';
import 'package:boi_system/view/listar_bois_page.dart';
import 'package:boi_system/view/inserir_boi_page.dart';
import 'package:boi_system/view/editar_boi_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boi System',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: const MyHomePage(title: 'Boi System'),
      routes: {
        Routes.edit: (context) => const EditarBoiPage(),
        Routes.insert: (context) => const InserirBoiPage(),
        Routes.list: (context) => const ListarBoisPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: const AppDrawer(),
    );
  }
}
