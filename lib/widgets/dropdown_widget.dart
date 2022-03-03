import 'package:flutter/material.dart';

import '../utils/translations.dart';

class DropDownWidget extends StatelessWidget {
  final String value;
  final ValueChanged<String?>? onChangedLanguage;

  const DropDownWidget(
      {Key? key, required this.value, required this.onChangedLanguage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = Translations.languages
        .map<DropdownMenuItem<String>>(
            (String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ))
        .toList();

    return DropdownButton<String>(
      value: value,
      icon: Icon(Icons.expand_more, color: Colors.white),
      iconSize: 15,
      elevation: 16,
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
      onChanged: onChangedLanguage,
      items: items,
    );
  }
}
