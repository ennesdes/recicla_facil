class CompanyModel {
  final String id;
  final String name;
  final bool active;
  final int type;

  CompanyModel({
    required this.id,
    required this.name,
    required this.active,
    required this.type,
  });

  // Método para criar uma instância de CompanyModel a partir de um JSON
  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'],
      name: json['name'],
      active: json['active'],
      type: json['type'],
    );
  }

  // Método para converter uma instância de CompanyModel para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'active': active,
      'type': type,
    };
  }
}
