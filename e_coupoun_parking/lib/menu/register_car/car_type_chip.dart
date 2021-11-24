import 'package:e_coupoun_parking/models/choiceChipSelection.dart';
import 'package:flutter/material.dart';

class ChoiceChips {
  static final all = <ChoiceChipData>[
    ChoiceChipData(
      label: '4Wheels',
      isSelected: true,
      selectedColor: Color(0xff16AA10),
      textColor: Colors.white,
    ),
    ChoiceChipData(
      label: 'Coupe',
      isSelected: false,
      selectedColor: Color(0xff16AA10),
      textColor: Colors.black,
    ),
    ChoiceChipData(
      label: 'Hatchback',
      isSelected: false,
      selectedColor: Color(0xff16AA10),
      textColor: Colors.black,
    ),
    ChoiceChipData(
      label: 'MPVs',
      isSelected: false,
      selectedColor: Color(0xff16AA10),
      textColor: Colors.black,
    ),
    ChoiceChipData(
      label: 'Sedan',
      isSelected: false,
      selectedColor: Color(0xff16AA10),
      textColor: Colors.black,
    ),
    ChoiceChipData(
      label: 'Sports',
      isSelected: false,
      selectedColor: Color(0xff16AA10),
      textColor: Colors.black,
    ),
    ChoiceChipData(
      label: 'SUVs',
      isSelected: false,
      selectedColor: Color(0xff16AA10),
      textColor: Colors.black,
    ),
    ChoiceChipData(
        label: 'Others',
        isSelected: false,
        selectedColor: Color(0xff16AA10),
        textColor: Colors.black),
  ];
}
