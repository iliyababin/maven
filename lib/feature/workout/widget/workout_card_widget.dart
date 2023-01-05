import 'package:Maven/common/model/workout.dart';
import 'package:flutter/material.dart';

class WorkoutCard extends StatelessWidget {
  final Workout workout;
  final Color backgroundColor;
  final Color borderColor;
  final Color accentColor;
  final VoidCallback onTap;
  final Color primaryTextColor;

  const WorkoutCard({
    Key? key,
    required this.workout,
    this.backgroundColor = Colors.black,
    this.accentColor = Colors.red,
    required this.borderColor,
    required this.onTap,
    required this.primaryTextColor
  }) : super(key: key);

  final double borderRadius = 8;

  @override
  Widget build(BuildContext context) {


    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        splashColor: Colors.black12,
        onTap: onTap,
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 1.0),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      //TODO: WORKOUT NAME
                      "${workout.name} ${workout.sortOrder}",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: primaryTextColor
                      ),
                    ),
                    /*IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_horiz,
                        color: accentColor,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),*/
                  ],
                ),
                SizedBox(height: 1,),
                Text(
                  "Chest, Triceps, Shoulders",
                  style: TextStyle(
                    fontSize: 15,
                    color: accentColor
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  "Description: Doing stuff",
                  style: TextStyle(
                    fontSize: 13,
                    color: primaryTextColor
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}
