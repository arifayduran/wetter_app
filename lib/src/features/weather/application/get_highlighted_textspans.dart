import 'package:flutter/material.dart';

List<TextSpan> getHighlightedTextSpans(String suggestion, String query) {
  final List<TextSpan> spans = [];
  final String lowerCaseSuggestion = suggestion.toLowerCase();
  final String lowerCaseQuery = query.toLowerCase();

  int start = 0;
  int indexOfQuery = lowerCaseSuggestion.indexOf(lowerCaseQuery, start);

  while (indexOfQuery != -1) {

    if (indexOfQuery > start) {
      spans.add(
        TextSpan(
          text: suggestion.substring(start, indexOfQuery),
          style: const TextStyle(color: Colors.white54),
        ),
      );
    }

    spans.add(
      TextSpan(
        text: suggestion.substring(indexOfQuery, indexOfQuery + query.length),
        style: const TextStyle(color: Colors.white),
      ),
    );

    start = indexOfQuery + query.length;
    indexOfQuery = lowerCaseSuggestion.indexOf(lowerCaseQuery, start);
  }

  if (start < suggestion.length) {
    spans.add(
      TextSpan(
        text: suggestion.substring(start),
        style: const TextStyle(color: Colors.white54),
      ),
    );
  }

  return spans;
}
