import 'package:Maven/common/widget/m_button.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/cupertino.dart';

import '../model/timed.dart';

class TimedPickerDialog extends StatelessWidget {
  const TimedPickerDialog({Key? key,
    required this.initialValue,
    this.onSubmit,
  }) : super(key: key);

  final Timed initialValue;
  final ValueChanged<Timed>? onSubmit;

  Expanded carousel({
    required Function(int) valueChanged,
    required String title,
    required int length,
    required int initialValue,
    required BuildContext context,
  }) {
    return Expanded(
      child: Column(
        children: [
          Center(
            child: Text(
              title,
              style: mt(context).textStyle.heading4,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 180,
            child: CupertinoPicker(
              scrollController: FixedExtentScrollController(initialItem: initialValue),
              magnification: 1.22,
              squeeze: 1.2,
              itemExtent: 32,
              looping: true,
              onSelectedItemChanged: (int value) => valueChanged(value),

              children: List.generate(length, (index) =>
                  Center(
                    child: Text(
                      index.toString(),
                      style: mt(context).textStyle.body1,
                    ),
                  ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [

              carousel(
                valueChanged: (int value) {
                  initialValue.hour = value;
                },
                title: 'Hours',
                length: 24,
                initialValue: initialValue.hour,
                context: context,
              ),

              carousel(
                valueChanged: (int value) {
                  initialValue.minute = value;
                },
                title: 'Minutes',
                length: 60,
                initialValue: initialValue.minute,
                context: context,
              ),

              carousel(
                valueChanged: (int value) {
                  initialValue.second = value;
                },
                title: 'Seconds',
                length: 60,
                initialValue: initialValue.second,
                context: context,
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
                backgroundColor: mt(context).color.background,
                borderColor: mt(context).color.secondary,
                child: Text(
                  'Cancel',
                  style: mt(context).textStyle.body1,
                ),
              ),

              const SizedBox(width: 16,),

              MButton(
                onPressed: (){
                  if(onSubmit != null) {
                    onSubmit!(initialValue);
                    Navigator.pop(context);
                  }
                },
                backgroundColor: mt(context).color.primary,
                borderRadius: 12,
                child: Text(
                  'Start',
                  style: mt(context).textStyle.button1,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}