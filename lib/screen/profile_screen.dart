import 'package:flutter/material.dart';
import 'package:maven/util/workout_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DataTable(
          columns: [
            DataColumn(label: Text('Set')),
            DataColumn(label: Text('Previous')),
            DataColumn(label: Text('LBS')),
            DataColumn(label: Text('Reps')),
          ],
          rows: [
            DataRow(
              cells: [
                DataCell(
                  GestureDetector(
                    onTap: () {
                      print("gottem");
                    },
                    child: Text('Row 1'),
                  ),
                ),
                DataCell(
                  GestureDetector(
                    onTap: () {
                      print("gottem");
                    },
                    child: Text('Row 1'),
                  ),
                ),
                DataCell(
                  GestureDetector(
                    onTap: () {
                      print("gottem");
                    },
                    child: Text('Row 1'),
                  ),
                ),
                DataCell(
                  GestureDetector(
                    onDoubleTap: () {
                      print("gottem");
                    },
                    child: Text('Row 4'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
