import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';

class ColorPickerDialog extends StatelessWidget {
  
  //final List<Color> availableColors;
  final Function(Color) onColorSelected;
  
  ColorPickerDialog({required this.onColorSelected, super.key});

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

  final List<Color> _availableColors = [
    Colors.black,
    Colors.yellow,
    Colors.green,
    AppColors.myDeleteColor,
    Colors.blue,
    Colors.purple,
    Colors.white,
    Colors.orange,
    Colors.pink,
    Colors.cyan

  ];
}