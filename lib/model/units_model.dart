class PhysicsUnit {
  final String quantity;
  final String unit;
  final String symbol;

  PhysicsUnit({required this.quantity, required this.unit, required this.symbol});

  // Convert JSON to Object
  factory PhysicsUnit.fromJson(Map<String, dynamic> json) {
    return PhysicsUnit(
      quantity: json['quantity'],
      unit: json['unit'],
      symbol: json['symbol'],
    );
  }

  // Convert Object to JSON
  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'unit': unit,
      'symbol': symbol,
    };
  }
}
