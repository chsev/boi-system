import 'package:boi_system/dao/boi_dao.dart';
import 'package:boi_system/dao/connection_factory.dart';
import 'package:boi_system/model/boi.dart';
import 'package:boi_system/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "editar_boi_page.dart";
import 'package:sqflite/sqflite.dart';

class ListarBoisPage extends StatefulWidget {
  static const String routeName = '/list';

  const ListarBoisPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListarBoisPageState();
}

class _ListarBoisPageState extends State<ListarBoisPage> {
  List<Boi> _lista = <Boi>[];

  @override
  void initState() {
    super.initState();
    _refreshList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _refreshList() async {
    // carrega todos e repinta a tela
    List<Boi> tempList = await _obterTodos();
    setState(() {
      _lista = tempList;
    });
  }

  // Future<List<Boi>> _obterTodos() async {
  //   // retorna a lista de bois
  //   return <Boi>[
  //     Boi(1, "boi 1", "raca1", 5),
  //     Boi(2, "boi 2", "raca2", 15),
  //     Boi(3, "boi 3", "raca3", 25)
  //   ];
  // }

  // void _removerBoi(int id) async {
  //   // dado um id, remove o boi da base
  //   // por enquanto não faz nada
  // }

  void _showItem(BuildContext context, int index) {
    // mostra um boi na dialog
    Boi boi = _lista[index];

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(boi.nome),
            content: Column(
              children: [
                Text("Nome: ${boi.nome}"),
                Text("Raça: ${boi.raca}"),
                Text("Idade: ${boi.idade} anos"),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Ok"))
            ],
          );
        });
  }

  void _editItem(BuildContext context, int index) {
    // chama tela de edição de boi
    Boi b = _lista[index];

    Navigator.pushNamed(
      context,
      EditarBoiPage.routeName,
      arguments: <String, int>{"id": b.id!},
    );
  }

  void _removeItem(BuildContext context, int index) {
    // confirmação de remoção
    Boi b = _lista[index];
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text("Remover Boi"),
              content: Text("Gostaria realmente de remover ${b.nome}?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Não"),
                ),
                TextButton(
                  child: const Text("Sim"),
                  onPressed: () {
                    _removerBoi(b.id!);
                    _refreshList();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  ListTile _buildItem(BuildContext context, int index) {
    // mostra um boi na lista
    Boi b = _lista[index];
    return ListTile(
      leading: const Icon(Icons.pets),
      title: Text(b.nome),
      subtitle: Text(b.raca),
      onTap: () {
        _showItem(context, index);
      },
      trailing: PopupMenuButton(
        itemBuilder: (context) {
          return const [
            PopupMenuItem(value: 'edit', child: Text('Editar')),
            PopupMenuItem(value: 'delete', child: Text('Remover'))
          ];
        },
        onSelected: (String value) {
          if (value == 'edit') {
            _editItem(context, index);
          } else {
            _removeItem(context, index);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // constrói a tela
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listagem de bois"),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: _lista.length,
        itemBuilder: _buildItem,
      ),
    );
  }

  Future<List<Boi>> _obterTodos() async {
    Database db = await ConnectionFactory.factory.database;
    BoiDAO dao = BoiDAO(db);

    List<Boi> tempList = await dao.obterTodos();
    ConnectionFactory.factory.close();
    return tempList;
  }

  void _removerBoi(int id) async {
    Database db = await ConnectionFactory.factory.database;
    BoiDAO dao = BoiDAO(db);

    await dao.remover(id);

    ConnectionFactory.factory.close();
  }
}
