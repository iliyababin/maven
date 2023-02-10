import 'package:flutter/material.dart';

import '../../../../theme/m_themes.dart';
import '../../../../widget/m_flat_button.dart';

enum MKeyboardType {
  regular,
  barbell,
  distance,
  time,
}

class MKeyboard extends StatefulWidget {
  const MKeyboard({Key? key,
    required this.mKeyboardType,
  }) : super(key: key);

  final MKeyboardType mKeyboardType;

  @override
  State<MKeyboard> createState() => _MKeyboardState();
}

class _MKeyboardState extends State<MKeyboard> {

  int _selectedTab = 2;

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 20, top: 12, bottom: 6),
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.none,
                  decoration: InputDecoration(
                      hintText: 'Weight',
                      hintStyle: TextStyle(
                          color: mt(context).text.primaryColor,
                          fontSize: 16
                      ),
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none
                  ),
                  style: TextStyle(
                      color: mt(context).text.primaryColor
                  ),
                ),
              ),

              Container(
                height: 2,
                color: mt(context).borderColor,
              ),

              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          numberTile(1),
                          numberTile(2),
                          numberTile(3),
                        ]
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          numberTile(4),
                          numberTile(5),
                          numberTile(6),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          numberTile(7),
                          numberTile(8),
                          numberTile(9),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 65,
                        child: Row(
                          children: [
                            MFlatButton(
                              onPressed: (){},
                              height: 65,
                              borderRadius: 0,
                              text: Text(
                                '0',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                    color: mt(context).text.primaryColor
                                ),
                              ),
                            ),
                            MFlatButton(
                              onPressed: (){},
                              height: 65,
                              borderRadius: 0,
                            ),
                            MFlatButton(
                              onPressed: (){
                                int selectionStart = _controller.selection.start;
                                int selectionEnd = _controller.selection.end;

                                if(selectionStart == 0 && selectionEnd == 0) return;

                                if (selectionStart == selectionEnd) {
                                  selectionStart = selectionStart - 1;
                                }

                                _controller.text = _controller.text.substring(0, selectionStart) +
                                    _controller.text.substring(selectionEnd);
                                _controller.selection =
                                    TextSelection.collapsed(offset: selectionStart);
                              },
                              height: 65,
                              borderRadius: 0,
                              icon: Icon(
                                Icons.backspace_rounded,
                                size: 25,
                                color: mt(context).icon.primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )

            ],
          ),
        ),

        Container(
          width: 1,
          color: mt(context).borderColor,
        ),

        Container(
          width: 70,
          child: Column(
            children: [
              MFlatButton(
                onPressed: (){
                  setState(() {
                    _selectedTab = 0;
                  });
                },
                borderRadius: 0,
                icon: Icon(
                    Icons.history_rounded
                ),
              ),
              MFlatButton(
                onPressed: (){
                  setState(() {
                    _selectedTab = 1;
                  });
                },
                borderRadius: 0,
                icon: Icon(
                    Icons.calculate_rounded
                ),
              ),
              MFlatButton(
                onPressed: (){
                  setState(() {
                    _selectedTab = 3;
                  });
                },
                borderRadius: 0,
                icon: Icon(
                    Icons.numbers_rounded
                ),
              ),
              MFlatButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                borderRadius: 0,
                icon: Icon(
                    Icons.check
                ),
              ),
            ],
          ),
        )

      ],
    );
  }

  MFlatButton numberTile(int number) {
    return MFlatButton(
      onPressed: (){
        int selectionStart = _controller.selection.start;
        int selectionEnd = _controller.selection.end;

        _controller.text = _controller.text.substring(0, selectionStart) +
            number.toString() +
            _controller.text.substring(selectionEnd);
        _controller.selection =
            TextSelection.collapsed(offset: selectionStart + 1, affinity: TextAffinity.upstream);
      },
      height: double.infinity,
      borderRadius: 0,
      text: Text(
        number.toString(),
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w900,
          color: mt(context).text.primaryColor,
        ),
      ),
    );
  }
}