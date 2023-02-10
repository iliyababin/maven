import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';

/// A custom button widget that can display a label, an icon, or both.
///
/// allows the user to customize the background color, border color, and size
/// of the button.
class MFlatButton extends StatefulWidget {
  final Text? text;
  final Color? backgroundColor;
  final Color? borderColor;
  final Icon? icon;
  final VoidCallback onPressed;
  final bool expand;
  final EdgeInsets padding;
  final double height;
  final double width;
  final double borderRadius;

  const MFlatButton({super.key,
    this.text,
    this.backgroundColor,
    this.borderColor,
    this.icon,
    required this.onPressed,
    this.expand = true,
    this.padding = const EdgeInsets.symmetric(vertical: 0),
    this.height = 42,
    this.width = double.infinity,
    this.borderRadius = 8,
  });


  @override
  State<MFlatButton> createState() => _MFlatButtonState();
}

class _MFlatButtonState extends State<MFlatButton> {
  @override
  Widget build(BuildContext context) {
    if(widget.width != double.infinity) {
      return widgetBuildButton(context);
    } else if(widget.expand) {
      return Expanded(
          child: widgetBuildButton(context)
      );
    } else {
      return widgetBuildButton(context);
    }
  }

  Widget widgetBuildButton(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: widget.borderColor ?? widget.backgroundColor ?? mt(context).backgroundColor
        ),
        color: widget.borderColor
      ),
      child: Material(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        color: widget.backgroundColor ?? mt(context).backgroundColor,
        child: InkWell(
          onTap: widget.onPressed,
          splashFactory: InkRipple.splashFactory,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(widget.icon != null) widget.icon!,
              if(widget.icon != null && widget.text != null) SizedBox(width: 2,),
              if(widget.text != null) widget.text!,
            ],
          ),
        ),
      ),
    );
  }
}
