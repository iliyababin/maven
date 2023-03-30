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
                      style: TextStyle(
                          fontSize: 20,
                          color: mt(context).text.primaryColor
                      ),
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
                  if(onSubmit != null) {
                    onSubmit!(initialValue);
                    Navigator.pop(context);
                  }
                },
                backgroundColor: mt(context).accentColor,
                borderRadius: 12,
                height: 50,
                child: Text(
                  'Submit',
                  style: TextStyle(
                      color: mt(context).text.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}