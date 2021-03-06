class Boi {
  int? id;
  String nome;
  String raca;
  int idade;

  Boi(this.id, this.nome, this.raca, this.idade);
  Boi.novo(this.nome, this.raca, this.idade);

  Map<String, dynamic> toMap() {
    return {
      'boi_id': id,
      'boi_nome': nome,
      'boi_raca': raca,
      'boi_idade': idade
    };
  }

  static Boi fromMap(Map<String, dynamic> map) {
    return Boi(
      map['boi_id'],
      map['boi_nome'],
      map['boi_raca'],
      map['boi_idade'],
    );
  }

  static List<Boi> fromMaps(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      return Boi.fromMap(maps[i]);
    });
  }
}
