import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';

class ColorPickerDialog extends StatelessWidget {
  
  //final List<Color> availableColors;
  final Function(Color) onColorSelected;
  
  ColorPickerDialog({required this.onColorSelected, super.key});

    final List<Color> _availableColors = [
    Colors.white,
    Colors.black,
    AppColors.myDeleteColor,
    const Color.fromRGBO(245, 137, 102, 1),
    const Color.fromRGBO(232, 181, 51, 1),
    AppColors.myCheckItGreen,
    const Color.fromRGBO(73, 123, 68, 1),
    const Color.fromRGBO(67, 174, 208, 1),
    const Color.fromRGBO(67, 100, 220, 1),
    const Color.fromRGBO(194, 97, 228, 1),
    const Color.fromRGBO(252, 134, 219, 1),
  ];

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Wähle eine Farbe', style: standardTextDecoration,),
      backgroundColor: AppColors.myCheckITDarkGrey,
      surfaceTintColor: AppColors.myCheckITDarkGrey,
      children: [
        Column(
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: _buildColorButtons(context),
            ),
            const SizedBox(height: 20,),
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: Text('Abbrechen', style: standardTextDecoration.copyWith(color: AppColors.myTextInputColor),))
          ],
        )
      ],
    );
  }

  List<Widget> _buildColorButtons(BuildContext context){
    return [
      for (var color in _availableColors)
      GestureDetector(
        onTap: () {
          onColorSelected(color);
          Navigator.pop(context);
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
      )
    ];
  }
}