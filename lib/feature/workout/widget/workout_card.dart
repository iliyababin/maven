import 'package:Maven/common/model/workout.dart';
import 'package:flutter/material.dart';

class WorkoutCard extends StatelessWidget {
  final Workout workout;
  final Color backgroundColor;
  final Color borderColor;
  final Color accentColor;

  const WorkoutCard({
    Key? key,
    required this.workout,
    this.backgroundColor = Colors.black,
    this.accentColor = Colors.red,
    required this.borderColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        splashColor: Colors.black12,
        onTap: (){},
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 1.0),
            borderRadius: BorderRadius.circular(10),
          ),

          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          workout.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800
                          ),
                        ),
                        SizedBox(height: 2,),
                        Text(
                          "5 exercises",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: accentColor
                          ),
                        ),
                        SizedBox(height: 2,),
                        const Flexible(
                          child: Text(
                            "Muscles: Chest, Tricep, ",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(height: 2,),
                        const Flexible(
                          child: Text(
                            "oasndpioasndo0ian soidans osdan oasibasdnoauisbosfb aosfub oaubs ofuabos ubaous oubasbuo",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.more_horiz,
                            color: accentColor,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        const Text("nah")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
