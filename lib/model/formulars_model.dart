class PhysicsFormula {
  final String name;
  final String formula;
  final String description;

  PhysicsFormula(
      {required this.name, required this.formula, required this.description});

  // Convert JSON to Object
  factory PhysicsFormula.fromJson(Map<String, dynamic> json) {
    return PhysicsFormula(
      name: json['name'],
      formula: json['formula'],
      description: json['description'],
    );
  }

  // Convert Object to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'formula': formula,
      'description': description,
    };
  }
}
