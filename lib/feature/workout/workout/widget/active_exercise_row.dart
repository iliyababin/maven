import 'package:flutter/material.dart';

class ActiveExerciseRow {

  static const double SPACER_SIZE = 10;

  static Row build({
    required Widget set,
    required Widget previous,
    required Widget option1,
    Widget? option2,
    Widget? option3,
    required Widget checkbox,
  }) {
    return Row(
      children: [

        const SizedBox(
          width: SPACER_SIZE,
        ),

        Container(
          alignment: Alignment.center,
          width: 35,
          child: set
        ),

        const SizedBox(
          width: SPACER_SIZE,
        ),

        Container(
          alignment: Alignment.center,
          width: 90,
          child: previous
        ),

        const SizedBox(
          width: SPACER_SIZE,
        ),

        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: option1
          )
        ),

        const SizedBox(
          width: SPACER_SIZE,
        ),

        if(option2 != null)
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: option2
            )
          ),

        if(option2 != null)
          const SizedBox(
            width: SPACER_SIZE,
          ),

        if(option3 != null)
          Expanded(
            child: Container(
                alignment: Alignment.center,
                child: option2
            )
          ),

        if(option3 != null)
          const SizedBox(
            width: SPACER_SIZE,
          ),

        SizedBox(
          width: 46,
          child: checkbox,
        ),

        const SizedBox(
          width: SPACER_SIZE,
        ),

      ],
    );
  }
}