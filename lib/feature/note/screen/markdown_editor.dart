import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:maven/common/common.dart';

import '../../theme/theme.dart';

class MarkdownEditor extends StatefulWidget {
  const MarkdownEditor({
    Key? key,
    required this.string,
  }) : super(key: key);

  final String string;

  @override
  State<MarkdownEditor> createState() => _MarkdownEditorState();
}

class _MarkdownEditorState extends State<MarkdownEditor> {
  late String string;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    string = widget.string;
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

            },
            icon: const Icon(
              Icons.help_outline,
            )
          ),
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
      body: Padding(
        padding: EdgeInsets.all(T(context).space.large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: T(context).color.surface,
                ),
                child: TextFormField(
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
                    hintText: 'Start typing...',
                    contentPadding: EdgeInsets.all(T(context).space.large),
                  ),
                ),
              ),
            ),
            const Heading(
              title: 'Preview',
              sliver: false,
              size: HeadingSize.medium,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: T(context).color.surface,
                ),
                child: Markdown(
                  softLineBreak: true,
                  padding: EdgeInsets.all(T(context).space.large),
                  data: string,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
