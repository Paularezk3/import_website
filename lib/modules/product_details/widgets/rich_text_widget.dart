import 'package:flutter/material.dart';

class DefaultRichTextWidget extends StatelessWidget {
  final String textFromDatabase;
  final TextAlign textAlign;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow overflow;
  const DefaultRichTextWidget(
      {required this.textFromDatabase,
      this.textAlign = TextAlign.start,
      this.style,
      this.maxLines,
      this.overflow = TextOverflow.clip,
      super.key});

  // Function to parse the text and return a list of TextSpans
  List<TextSpan> parseText(String text) {
    List<TextSpan> spans = [];
    final boldRegex = RegExp(r'\*\*(.*?)\*\*');
    final italicRegex = RegExp(r'_(.*?)_');

    int lastMatchEnd = 0;
    final matches = [
      ...boldRegex.allMatches(text),
      ...italicRegex.allMatches(text)
    ];
    matches
        .sort((a, b) => a.start.compareTo(b.start)); // Sort by start position

    for (final match in matches) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(
            text:
                text.substring(lastMatchEnd, match.start))); // Add normal text
      }

      if (boldRegex.hasMatch(match.group(0)!)) {
        spans.add(TextSpan(
          text: match.group(1),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ));
      } else if (italicRegex.hasMatch(match.group(0)!)) {
        spans.add(TextSpan(
          text: match.group(1),
          style: const TextStyle(fontStyle: FontStyle.italic),
        ));
      }

      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(
          text: text.substring(lastMatchEnd))); // Add remaining normal text
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: style,
        children: parseText(textFromDatabase),
      ),
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
