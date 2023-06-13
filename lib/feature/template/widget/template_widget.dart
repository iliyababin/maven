import 'package:flutter/material.dart';
import 'package:maven/common/widget/m_button.dart';

import '../../../database/model/template.dart';
import '../../../theme/widget/inherited_theme_widget.dart';
import '../screen/template_detail_screen.dart';

class TemplateWidget extends StatefulWidget {
  const TemplateWidget({Key? key,
    required this.template,
  }) : super(key: key);

  final Template template;

  @override
  State<TemplateWidget> createState() => _TemplateWidgetState();
}

class _TemplateWidgetState extends State<TemplateWidget> {
  final double _borderRadius = 10;
  late bool? _completed;

  @override
  void initState() {
    _completed = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: T(context).color.background,
      borderRadius: BorderRadius.circular(_borderRadius),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => TemplateDetailScreen(
            template: widget.template,
          )));
        },
        borderRadius: BorderRadius.circular(_borderRadius),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_borderRadius),
            border: Border.all(
              color: T(context).color.secondary,
            ),
          ),
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              _completed != null ? Padding(
                padding: const EdgeInsetsDirectional.only(end: 10),
                child: MButton(
                  onPressed: (){
                    setState(() {
                      _completed = !_completed!;
                    });
                    /*context.read<ProgramDetailBloc>().add(ProgramDetailTemplateTrackerUpdate(
                      templateTracker: widget.template.templateTracker!.copyWith(
                        completed: _completed,
                      ),
                    ));*/
                  },
                  width: 40,
                  height: 40,
                  expand: false,
                  child: _completed! ? Icon(
                    Icons.check_circle_outline_outlined,
                    color: T(context).color.success,
                    size: 28,
                  ) : Icon(
                    Icons.circle_outlined,
                    color: T(context).color.secondary,
                    size: 28,
                  )
                ),
              ) : Container(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.template.name,
                    style: T(context).textStyle.heading3,
                    maxLines: 1,
                  ),
                  /*const SizedBox(height: 3,),
                  Text(
                    'Chest, Triceps, Shoulders',
                    style: T(context).textStyle.subtitle2,
                  ),*/
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    widget.template.description,
                    style: T(context).textStyle.subtitle1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
