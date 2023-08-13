import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../theme/theme.dart';
import '../screen/markdown_editor.dart';

class NoteWidget extends StatefulWidget {
  const NoteWidget({
    Key? key,
    required this.note,
    required this.onChanged,
  }) : super(key: key);

  final String note;
  final Function(String value) onChanged;

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  late bool editing = false;
  late FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return editing
        ? Row(
            children: [
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 20,
                  focusNode: focusNode,
                  onChanged: (value) {
                    widget.onChanged(value);
                  },
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      editing = false;
                    });
                  },
                  initialValue: widget.note,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(0.0),
                    isDense: true,
                    border: InputBorder.none,
                  ),
                  style: T(context).textStyle.bodyMedium,
                ),
              ),
            ],
          )
        : GestureDetector(
            onTap: () {
              setState(() {
                focusNode.requestFocus();
                editing = true;
              });
            },
            child: widget.note.isNotEmpty
                ? Row(
                    children: [
                      Flexible(
                        child: MarkdownBody(
                          softLineBreak: true,
                          data: widget.note,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return MarkdownEditor(
                                  string: widget.note,
                                );
                              },
                            ),
                          ).then((value) {
                            if (value != null) {
                              widget.onChanged(value);
                            }
                          });
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          Icons.edit_rounded,
                          size: T(context).textStyle.bodyLarge.fontSize,
                        ),
                      ),
                    ],
                  )
                : Text(
                    'Add a note',
                    style: TextStyle(
                      color: T(context).color.onSurfaceVariant,
                    ),
                  ),
          );
  }
}
