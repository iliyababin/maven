import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../theme/theme.dart';

class MarkdownEditor extends StatefulWidget {
  const MarkdownEditor({
    Key? key,
    required this.note,
  }) : super(key: key);

  final String note;

  @override
  State<MarkdownEditor> createState() => _MarkdownEditorState();
}

class _MarkdownEditorState extends State<MarkdownEditor> {
  late String string;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    string = widget.note;
    _textEditingController.text = string;
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editor'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context, string);
            },
            icon: const Icon(
              Icons.check,
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  contextMenuBuilder: null,
                  controller: _textEditingController,
                  maxLines: null,
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  style: T(context).textStyle.bodyMedium,
                  onChanged: (value) {
                    setState(() {
                      string = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter a note...',
                    contentPadding: EdgeInsets.all(T(context).space.large),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: T(context).color.outline,
            height: 1,
            width: double.infinity,
          ),
          Expanded(
            child: Markdown(
              padding: EdgeInsets.all(T(context).space.large),
              data: string,
            ),
          ),
        ],
      ),
    );
  }
}
