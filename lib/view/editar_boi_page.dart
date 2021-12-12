import 'package:boi_system/dao/boi_dao.dart';
import 'package:boi_system/dao/connection_factory.dart';
import 'package:boi_system/helper/error.dart';
import 'package:boi_system/repositories/boi_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:boi_system/model/boi.dart';
import 'package:boi_system/widgets/drawer.dart';
import 'package:sqflite/sqflite.dart';

class EditarBoiPage extends StatefulWidget {
  static const String routeName = '/edit';

  const EditarBoiPage({Key? key}) : super(key: key);
  @override
  _EditarBoiState createState() => _EditarBoiState();
}

class _EditarBoiState extends State<EditarBoiPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _racaController = TextEditingController();
  final _idadeController = TextEditingController();
  int _id = 0;
  Boi? _boi;

  @override
  void dispose() {
    _nomeController.dispose();
    _racaController.dispose();
    _idadeController.dispose();
    super.dispose();
  }

  // void _obterBoi() async {
  //   // nada aqui por enquanto
  //   _boi = Boi(_id, "Boi $_id", "Raça", 10);
  //   _nomeController.text = _boi!.nome;
  //   _racaController.text = _boi!.raca;
  //   _idadeController.text = _boi!.idade.toString();
  // }

  // void _salvar() async {
  //   _boi!.nome = _nomeController.text;
  //   _boi!.raca = _racaController.text;
  //   _boi!.idade = int.parse(_idadeController.text);
  //   // nada aqui por enquanto
  //   ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Boi editado com sucesso.')));
  // }

  Widget _buildForm(BuildContext context) {
    return Column(children: [
      Form(
          key: _formKey,
          child: ListView(shrinkWrap: true, children: [
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              const Text("Nome:"),
              Expanded(
                  child: TextFormField(
                controller: _nomeController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo não pode ser vazio';
                  }
                  return null;
                },
              ))
            ]),
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              const Text("Raça:"),
              Expanded(
                  child: TextFormField(
                controller: _racaController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo não pode ser vazio';
                  }
                  return null;
                },
              ))
            ]),
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              const Text("Idade:"),
              Expanded(
                  child: TextFormField(
                controller: _idadeController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo não pode ser vazio';
                  }
                  return null;
                },
              ))
            ]),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _salvar();
                    }
                  },
                  child: const Text('Salvar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancelar'),
                ),
              ],
            )
          ])) // Form
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final Map m = ModalRoute.of(context)!.settings.arguments as Map;
    _id = m["id"];
    _obterBoi();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Boi"),
      ),
      drawer: const AppDrawer(),
      body: _buildForm(context),
    );
  }

  // void _obterBoi() async {
  //   Database db = await ConnectionFactory.factory.database;
  //   BoiDAO dao = BoiDAO(db);
  //   _boi = await dao.obterPorId(_id);

  //   ConnectionFactory.factory.close();

  //   _nomeController.text = _boi!.nome;
  //   _racaController.text = _boi!.raca;
  //   _idadeController.text = _boi!.idade.toString();
  // }

  // void _salvar() async {
  //   _boi!.nome = _nomeController.text;
  //   _boi!.raca = _racaController.text;
  //   _boi!.idade = int.parse(_idadeController.text);

  //   Database db = await ConnectionFactory.factory.database;
  //   BoiDAO dao = BoiDAO(db);
  //   await dao.atualizar(_boi!);

  //   ConnectionFactory.factory.close();

  //   ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Boi editado com sucesso.")));
  // }

  void _obterBoi() async {
    try {
      BoiRepository repository = BoiRepository();
      _boi = await repository.buscar(_id);
      _nomeController.text = _boi!.nome;
      _racaController.text = _boi!.raca;
      _idadeController.text = _boi!.idade.toString();
    } catch (exception) {
      showError(context, "Erro recuperando boi", exception.toString());
      Navigator.pop(context);
    }
  }

  void _salvar() async {
    _boi!.nome = _nomeController.text;
    _boi!.raca = _racaController.text;
    _boi!.idade = int.parse(_idadeController.text);
    try {
      BoiRepository repository = BoiRepository();
      await repository.alterar(_boi!);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Boi editado com sucesso.')));
    } catch (exception) {
      showError(context, "Erro editando boi", exception.toString());
    }
  }
}
