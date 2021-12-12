import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:boi_system/routes/routes.dart";

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  Widget _createDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(padding: const EdgeInsets.only(left: 8.0), child: Text(text))
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _createHeader() {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(
          color: Colors.blue,
          image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage('assets/images/vaca.png'))),
      child: Stack(
        children: const <Widget>[
          Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text(
              "Cadastro de Bois",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              icon: Icons.add,
              text: "Inserir Boi",
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.insert)),
          const Divider(),
          _createDrawerItem(
              icon: Icons.list,
              text: "Listar Bois",
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.list)),
          ListTile(
            title: const Text("0.0.1"),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
