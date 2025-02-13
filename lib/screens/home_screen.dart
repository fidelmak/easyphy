import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const/color.dart';
import '../phyProvider/units_provider.dart';

class UnitListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: nov,
          title: Text(
            'Physics Units',
            style: TextStyle(color: Colors.white),
          )),
      body: Consumer<PhysicsProvider>(
        builder: (context, provider, child) {
          if (provider.units.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: provider.units.length,
            itemBuilder: (context, index) {
              final unit = provider.units[index];
              return ListTile(
                title: Text(unit.quantity),
                subtitle: Text('${unit.unit} (${unit.symbol})'),
              );
            },
          );
        },
      ),
    );
  }
}
