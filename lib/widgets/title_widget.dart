import 'package:flutter/material.dart';

import 'dropdown_widget.dart';

class TitleWidget extends StatelessWidget {
  final String language1;
  final String language2;
  final ValueChanged<String?>? onChangedLanguage1;
  final ValueChanged<String?>? onChangedLanguage2;

  const TitleWidget(
      {Key? key,
      required this.language1,
      required this.language2,
      required this.onChangedLanguage1,
      required this.onChangedLanguage2})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'From:  ',
              style: TextStyle(fontSize: 15),
            ),
          ),
          DropDownWidget(
            value: language1,
            onChangedLanguage: onChangedLanguage1,
          ),
          SizedBox(width: 12),
          Text(
            'To: ',
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(width: 12),
          DropDownWidget(
            value: language2,
            onChangedLanguage: onChangedLanguage2,
          ),
        ],
      );
}
