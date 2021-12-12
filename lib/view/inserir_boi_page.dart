import 'package:boi_system/dao/boi_dao.dart';
import 'package:boi_system/dao/connection_factory.dart';
import 'package:boi_system/model/boi.dart';
import 'package:flutter/material.dart';
import 'package:boi_system/widgets/drawer.dart';
import 'package:sqflite/sqflite.dart';

class InserirBoiPage extends StatefulWidget {
  static const String routeName = '/insert';

  const InserirBoiPage({Key? key}) : super(key: key);
  @override
  _InserirBoiState createState() => _InserirBoiState();
}

class _InserirBoiState extends State<InserirBoiPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _racaController = TextEditingController();
  final _idadeController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _racaController.dispose();
    _idadeController.dispose();
    super.dispose();
  }

  // void _salvar() async {
  //   // Nada aqui por enquanto
  //   _nomeController.clear();
  //   _racaController.clear();
  //   _idadeController.clear();
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(const SnackBar(content: Text('Boi salvo com sucesso.')));
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
              ],
            )
          ])) // Form
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inserir Boi"),
      ),
      drawer: const AppDrawer(),
      body: _buildForm(context),
    );
  }

  void _salvar() async {
    Database db = await ConnectionFactory.factory.database;
    BoiDAO dao = BoiDAO(db);

    Boi boi = Boi.novo(_nomeController.text, _racaController.text,
        int.parse(_idadeController.text));

    await dao.inserir(boi);
    ConnectionFactory.factory.close();

    _nomeController.clear();
    _racaController.clear();
    _idadeController.clear();

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Boi salvo com sucesso.")));
  }
}
