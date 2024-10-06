import 'package:flutter/material.dart';

class CopyableText extends StatefulWidget {
  @override
  _CopyableTextState createState() => _CopyableTextState();
}

class _CopyableTextState extends State<CopyableText> {
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Unfocus any text selection when tapping outside
        _focusNode1.unfocus();
        _focusNode2.unfocus();
      },
      child: Row(
        children: [
          SelectableText(
            "01015811730",
            style: Theme.of(context).textTheme.bodySmall,
            focusNode: _focusNode1, // Assign the FocusNode to the first SelectableText
          ),
          Text(
            " - ",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SelectableText(
            "01206120110",
            style: Theme.of(context).textTheme.bodySmall,
            focusNode: _focusNode2, // Assign the FocusNode to the second SelectableText
          ),
        ],
      ),
    );
  }
}
