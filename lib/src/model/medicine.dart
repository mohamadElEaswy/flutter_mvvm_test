class Medicine {
  String? name;
  String? description;
  double? strength;
  int? id;

  Medicine({this.name, this.description, this.strength});

  Medicine.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    strength = json['strength'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['strength'] = strength;
    data['id'] = id;
    return data;
  }
}
