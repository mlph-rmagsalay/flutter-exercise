import 'package:flutter/material.dart';
import 'package:flutter_exercise/shared/widgets/center_app_bar.dart';
import 'package:flutter_exercise/presentation/equipment_list/view/equipment_list_view.dart';
import '../../equipment_list/view/assigned_equipment_list_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CenterAppBar(
        'MLPH Equipment App',
        context,
        shouldShowLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to "Not Assigned Equipment" view
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EquipmentListView(),
                  ),
                );
              },
              child: const Text('List of Available Equipments'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // Navigate to "Assigned Equipment" view
                    builder: (context) => AssignedEquipmentListView(),
                  ),
                );
              },
              child: const Text('List of Assigned Equipments'),
            ),
          ],
        ),
      ),
    );
  }
}
