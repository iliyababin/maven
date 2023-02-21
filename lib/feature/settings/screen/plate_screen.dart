import 'package:Maven/feature/settings/screen/edit_plate_screen.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:Maven/widget/custom_app_bar.dart';
import 'package:Maven/widget/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../workout/m_keyboard/dao/plate_dao.dart';
import '../../workout/m_keyboard/model/plate.dart';

class PlateScreen extends StatefulWidget {
  const PlateScreen({Key? key}) : super(key: key);

  @override
  State<PlateScreen> createState() => _PlateScreenState();
}

class _PlateScreenState extends State<PlateScreen> {


  @override
  Widget build(BuildContext context) {
    return CustomScaffold.build(
      context: context,
      appBar: CustomAppBar.build(
        context: context,
        title: 'Plates',
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_rounded,
              color: mt(context).icon.accentColor,
            ),
            onPressed: () {},
          )
        ]
      ),
      body: FutureBuilder(
        future: context.read<PlateDao>().getPlates(),
        builder: (BuildContext context, AsyncSnapshot<List<Plate>> snapshot) {
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditPlateScreen(
                      plate: plate,
                    )),
                  );
                },
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
