import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/formulars_model.dart';

class PhysicsFormulaProvider extends ChangeNotifier {
  List<PhysicsFormula> _formulas = [];

  List<PhysicsFormula> get formulas => _formulas;

  // Load JSON from `lib/data/physics_formulas.json`
  Future<void> loadFormulas() async {
    try {
      //final file = File('assets/data/formulars.json');
      final String response =
          await rootBundle.loadString('assets/data/formulars.json');
      final List<dynamic> data = jsonDecode(response);

      _formulas = data.map((item) => PhysicsFormula.fromJson(item)).toList();
      notifyListeners();
    } catch (e) {
      print('Error loading formulas: $e');
    }
  }
}
