import 'package:flutter/material.dart';

class FlatButton extends StatefulWidget {
  final Text text;
  final Color color;
  final Color borderColor;
  final Icon icon;
  final VoidCallback onPressed;
  final bool showIcon;

  const FlatButton({super.key,
    required this.text,
    required this.color,
    this.borderColor = Colors.transparent,
    this.icon = const Icon(Icons.deblur),
    required this.onPressed,
    required this.showIcon,
  });


  @override
  State<FlatButton> createState() => _FlatButtonState();
}

class _FlatButtonState extends State<FlatButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 42,
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(widget.color),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                    width: 1, // thickness
                    color: widget.borderColor  // color
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
              if(widget.showIcon) widget.icon,
              SizedBox(width: 8,),
              widget.text
            ],
          ),
        ),
      ),
    );
  }
}
