import 'package:flutter/material.dart';

class FlatButton extends StatefulWidget {
  final String text;
  final Color color;
  final bool showBorder;
  final Color borderColor;
  final IconData icon;
  final Function onPressed;

  const FlatButton({super.key,
    required this.text,
    required this.color,
    required this.showBorder,
    this.borderColor = Colors.transparent,
    required this.icon,
    required this.onPressed,
  });


  @override
  State<FlatButton> createState() => _FlatButtonState();
}

class _FlatButtonState extends State<FlatButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 45,
        child: ElevatedButton(
          onPressed: (){},
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
            overlayColor: MaterialStateProperty.resolveWith((states) {
              if(widget.showBorder){
                return widget.borderColor;
              } else {
                return null;
              }
            }
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color: widget.color
              ),
              SizedBox(width: 8,),
              Text(
                'Workout Builder',
                style: TextStyle(
                  color: widget.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
