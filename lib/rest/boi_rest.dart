import 'package:boi_system/model/boi.dart';
import 'package:boi_system/rest/api.dart';
import 'package:http/http.dart' as http;

class BoiRest {
  Future<Boi> buscar(int id) async {
    final http.Response response =
        await http.get(Uri.http(API.endpoint, '/bois/$id'));
    if (response.statusCode == 200) {
      return Boi.fromJson(response.body);
    } else {
      throw Exception(
          'Erro buscando boi: ${id} [code: ${response.statusCode}]');
    }
  }

  Future<List<Boi>> buscarTodos() async {
    final http.Response response =
        await http.get(Uri.http(API.endpoint, "bois"));

    if (response.statusCode == 200) {
      return Boi.fromJsonList(response.body);
    } else {
      throw Exception('Erro buscando todos os bois');
    }
  }

  Future<Boi> inserir(Boi boi) async {
    final http.Response response =
        await http.post(Uri.http(API.endpoint, "bois"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: boi.toJson());
    if (response.statusCode == 201) {
      return Boi.fromJson(response.body);
    } else {
      throw Exception('Erro inserindo Boi');
    }
  }

  Future<Boi> alterar(Boi boi) async {
    final http.Response response = await http.put(
      Uri.http(API.endpoint, 'bois/${boi.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: boi.toJson(),
    );

    if (response.statusCode == 200) {
      return boi;
    } else {
      throw Exception("Erro alterando boi ${boi.id}");
    }
  }

  Future<Boi> remover(int id) async {
    final http.Response response = await http
        .delete(Uri.http(API.endpoint, 'bois/$id'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    });

    if (response.statusCode == 200) {
      return Boi.novo('nome', 'raca', 0);
      // return Boi.fromJson(response.body); //Retorna null e causa erro
    } else {
      throw Exception("Erro removendo boi: $id");
    }
  }
}
