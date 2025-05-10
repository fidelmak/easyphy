import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/units_model.dart';

class PhysicsProvider extends ChangeNotifier {
  List<PhysicsUnit> _units = [];

  List<PhysicsUnit> get units => _units;

  // Load units from a JSON file
  Future<void> loadUnits() async {
    final response = await rootBundle.loadString('assets/data/units.json');
    final List<dynamic> data = jsonDecode(response);
    _units = data.map((item) => PhysicsUnit.fromJson(item)).toList();
    notifyListeners();
  }
}
