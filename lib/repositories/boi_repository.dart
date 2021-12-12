import 'package:boi_system/model/boi.dart';
import 'package:boi_system/rest/boi_rest.dart';

class BoiRepository {
  final BoiRest api = BoiRest();
  Future<Boi> buscar(int id) async {
    return await api.buscar(id);
  }

  Future<List<Boi>> buscarTodos() async {
    return await api.buscarTodos();
  }

  Future<Boi> inserir(Boi boi) async {
    return await api.inserir(boi);
  }

  Future<Boi> alterar(Boi boi) async {
    return await api.alterar(boi);
  }

  Future<Boi> remover(int id) async {
    return await api.remover(id);
  }
}
