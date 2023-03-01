
import 'package:Maven/main.dart';
import 'package:flutter/material.dart';

import '../../../theme/m_themes.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_scaffold.dart';
import '../model/plate.dart';
import '../service/equipment_service.dart';
import 'edit_plate_screen.dart';


class PlateScreen extends StatefulWidget {
  const PlateScreen({Key? key,
    required this.equipmentService,
  }) : super(key: key);

  final EquipmentService equipmentService;

  @override
  State<PlateScreen> createState() => _PlateScreenState();
}

class _PlateScreenState extends State<PlateScreen> {

  void editPlate(Plate plate) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePlateScreen(
      equipmentService: services<EquipmentService>(),
      plate: plate,
    )));
  }
  @override
  Widget build(BuildContext context) {
    return CustomScaffold.build(
      context: context,
      appBar: CustomAppBar.build(
        context: context,
        title: 'Plates',
        actions: [
          IconButton(
            onPressed: () async {
              Plate plate = await widget.equipmentService.addEmptyPlate();
              editPlate(plate);
            },
            icon: Icon(
              Icons.add_rounded,
              color: mt(context).icon.accentColor,
            ),
          )
        ]
      ),
      body: StreamBuilder(
        stream: widget.equipmentService.getPlatesAsStream(),
        builder: (context, snapshot)  {
          if(!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          List<Plate> plates = snapshot.data!;

          return ListView.builder(
            itemCount: plates.length,
            itemBuilder: (context, index) {
              Plate plate = plates[index];
              return ListTile(
                onTap: () => editPlate(plate),
                leading: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: plate.color,
                    borderRadius: BorderRadiusDirectional.circular(50),
                  ),
                ),
                title: Text(
                  plate.weight.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    color: mt(context).text.primaryColor,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: mt(context).icon.accentColor,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
