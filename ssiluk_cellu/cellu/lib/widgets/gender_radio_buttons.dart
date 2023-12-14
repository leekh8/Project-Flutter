import 'package:flutter/material.dart';

enum Gender { male, female }

class GenderRadioButtons extends StatelessWidget {
  final Gender gender;
  final ValueChanged<Gender?> onChanged;

  GenderRadioButtons({required this.gender, required this.onChanged});

  Widget _buildRadio(Gender value, String text) {
    return Expanded(
      child: RadioListTile<Gender>(
        title: Text(text),
        value: value,
        groupValue: gender,
        onChanged: onChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _buildRadio(Gender.male, '남'),
        _buildRadio(Gender.female, '여'),
      ],
    );
  }
}
