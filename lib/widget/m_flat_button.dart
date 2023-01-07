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

  const MFlatButton({super.key,
    this.text,
    this.backgroundColor = Colors.transparent,
    this.borderColor,
    this.icon,
    required this.onPressed,
    this.expand = true,
    this.padding = const EdgeInsets.symmetric(vertical: 0),
    this.height = 42,
    this.width = double.infinity,
  });


  @override
  State<MFlatButton> createState() => _MFlatButtonState();
}

class _MFlatButtonState extends State<MFlatButton> {
  @override
  Widget build(BuildContext context) {
    if(widget.expand) {
      return Expanded(
        child: widgetBuildButton(context)
      );
    } else {
      return widgetBuildButton(context);
    }
  }

  Widget widgetBuildButton(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(Size.zero),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(widget.padding),
          backgroundColor: MaterialStateProperty.all<Color>(widget.backgroundColor!),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                width: widget.borderColor != null ? 1 : 0,
                color: widget.borderColor != null ? widget.borderColor! : Colors.transparent
              ),
            ),
          ),
          elevation: MaterialStateProperty.all<double?>(0),
          overlayColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
            return widget.borderColor != Colors.transparent ? widget.borderColor : null;
          }),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(widget.icon != null) widget.icon!,
            if(widget.icon != null && widget.text != null) SizedBox(width: 8,),
            if(widget.text != null) widget.text!,
          ],
        ),
      ),
    );
  }
}
