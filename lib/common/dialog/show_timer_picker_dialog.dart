import 'package:Maven/common/widget/m_button.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/timed.dart';

showTimerPickerDialog({
  required BuildContext context,
}) async {

  Timed timed = Timed(hour: 0, minute: 0, second: 0);

  ///
  /// Widgets
  ///
  Expanded carousel({
    required Function(int) valueChanged,
    required String title,
    required int length,
  }) {
    return Expanded(
      child: Column(
        children: [
          Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: mt(context).text.primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 180,
            child: CupertinoPicker(
              magnification: 1.22,
              squeeze: 1.2,
              itemExtent: 32,
              looping: true,
              onSelectedItemChanged: (int value) => valueChanged(value),

              children: List.generate(length, (index) =>
                  Center(
                      child: Text(
                        index.toString(),
                        style: TextStyle(
                            fontSize: 20,
                            color: mt(context).text.primaryColor
                        ),
                      )
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }

  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
            color: mt(context).backgroundColor,
            borderRadius: const BorderRadiusDirectional.only(topEnd: Radius.circular(15), topStart: Radius.circular(15))
        ),
        height: 330,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              Row(
                mainAxisSize: MainAxisSize.max,
                children: [

                  carousel(
                    valueChanged: (int value) {
                      timed.hour = value;
                    },
                    title: 'Hours',
                    length: 24
                  ),

                  carousel(
                    valueChanged: (int value) {
                      timed.minute = value;
                    },
                    title: 'Minutes',
                    length: 60
                  ),

                  carousel(
                    valueChanged: (int value) {
                      timed.second = value;
                    },
                    title: 'Seconds',
                    length: 60
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisSize: MainAxisSize.max,
                children: [

                  MButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },

                    expand: true,
                    height: 40,
                    borderColor: mt(context).borderColor,
                    backgroundColor: mt(context).backgroundColor,
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: mt(context).text.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  const SizedBox(width: 16,),

                  MButton(
                    onPressed: (){
                      Navigator.pop(context, timed);
                    },
                    expand: true,
                    height: 38,
                    backgroundColor: mt(context).accentColor,
                    child: Text(
                      'Start',
                      style: TextStyle(
                        color: mt(context).text.whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
