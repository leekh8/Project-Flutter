import 'package:flutter/material.dart';

enum DiabetesType { type1, type2, none }

class DiabetesTypeRadioButtons extends StatelessWidget {
  final DiabetesType diabetesType;
  final ValueChanged<DiabetesType?> onChanged;

  DiabetesTypeRadioButtons(
      {required this.diabetesType, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final diabetesTypeText = {
      DiabetesType.type1: '제1형',
      DiabetesType.type2: '제2형',
      DiabetesType.none: '없음',
    };

    return Column(
      children: DiabetesType.values.map((type) {
        return RadioListTile<DiabetesType>(
          title: Text(diabetesTypeText[type] ?? ''),
          value: type,
          groupValue: diabetesType,
          onChanged: onChanged,
        );
      }).toList(),
    );
  }
}
