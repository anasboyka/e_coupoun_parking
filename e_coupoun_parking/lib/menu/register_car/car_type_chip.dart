import '../../models/choiceChipSelection.dart';
import 'package:flutter/material.dart';

class ChoiceChips {
  List<ChoiceChipData> allList = <ChoiceChipData>[
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

  var all = <ChoiceChipData>[
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

  List<ChoiceChipData> geteditedList(String label) {
    List<ChoiceChipData> newChoice = [];
    this.allList.forEach((e) {
      if (e.label == label) {
        newChoice.add(ChoiceChipData(
            label: label,
            isSelected: true,
            textColor: Colors.white,
            selectedColor: Color(0xff16AA10)));
      } else {
        newChoice.add(ChoiceChipData(
            label: e.label,
            isSelected: false,
            textColor: Colors.black,
            selectedColor: e.selectedColor));
      }
    });
    return newChoice;
  }
}
