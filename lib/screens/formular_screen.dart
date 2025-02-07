import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const/color.dart';
import '../phyProvider/formulars_provider.dart';

class FormulaListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: mama,
          title:
              Text('Physics Formulas', style: TextStyle(color: Colors.black))),
      body: Consumer<PhysicsFormulaProvider>(
        builder: (context, provider, child) {
          if (provider.formulas.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: provider.formulas.length,
            itemBuilder: (context, index) {
              final formula = provider.formulas[index];
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(formula.name,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Formula: ${formula.formula}",
                          style: TextStyle(color: Colors.blue)),
                      Text(formula.description),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
