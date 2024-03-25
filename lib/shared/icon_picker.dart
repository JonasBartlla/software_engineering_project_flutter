import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';

class IconPickerDialog extends StatelessWidget {

  final Function(IconData) onIconSelected;
  IconPickerDialog({required this.onIconSelected, super.key});



  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Wähle ein Icon', style: standardTextDecoration),
      backgroundColor: AppColors.myCheckITDarkGrey,
      surfaceTintColor: AppColors.myCheckITDarkGrey,
      children: [
        Column(
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _buildIconButtons(context),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: Text('Abbrechen', style: standardTextDecoration.copyWith(color: AppColors.myTextInputColor),),
              ),
          ],
        )
      ],
    );
  }
  List<Widget> _buildIconButtons(BuildContext context){
  return [
    for (var iconData in _availableIcons)
      IconButton(
        onPressed: (){
          onIconSelected(iconData);
          Navigator.pop(context);
        }, 
        icon: Icon(iconData, color: AppColors.myCheckItGreen, size: 35,)
        )
  ];
}

final List<IconData> _availableIcons = [
  Icons.laptop,
  Icons.ramen_dining,
  //TestIcons
  Icons.abc,
  Icons.house_rounded,
  Icons.directions,
  Icons.access_alarm,
  Icons.smart_button,
  Icons.calendar_month,
];
}

