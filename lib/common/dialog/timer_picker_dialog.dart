import 'package:flutter/cupertino.dart';
import 'package:maven/common/widget/m_button.dart';

import '../../theme/widget/inherited_theme_widget.dart';
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
              style: T(context).textStyle.titleMedium,
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
                    style: T(context).textStyle.bodyLarge.copyWith(
                      color: T(context).color.onSurface,
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
                backgroundColor: T(context).color.background,
                borderColor: T(context).color.secondary,
                child: Text(
                  'Cancel',
                  style: T(context).textStyle.bodyLarge,
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
                backgroundColor: T(context).color.primary,
                borderRadius: 12,
                child: Text(
                  'Submit',
                  style: T(context).textStyle.labelLarge,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}