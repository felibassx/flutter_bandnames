class BandModel {
  String id;
  String name;
  int votes;

  BandModel({this.id, this.name, this.votes});

  // factory constructor, retorna una nueva instancia del objeto a partir del objet recibido
  factory BandModel.fromMap(Map<String, dynamic> obj) =>
      BandModel(id: obj['id'], name: obj['name'], votes: obj['votes']);
}
