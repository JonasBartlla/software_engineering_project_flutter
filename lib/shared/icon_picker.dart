import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';

class IconPickerDialog extends StatelessWidget {

  final Function(IconData) onIconSelected;
  Color iconColor;
  IconPickerDialog({required this.onIconSelected, required this.iconColor, super.key});

  final List<IconData> _availableIcons = [
    Icons.format_list_bulleted_rounded,
    Icons.school_rounded,
    Icons.laptop_chromebook_rounded,
    Icons.shopping_cart_rounded,
    Icons.games_rounded,
    Icons.flatware_rounded,
    Icons.kitchen_rounded,
    Icons.icecream_rounded,
    Icons.ramen_dining_rounded,
    Icons.sports_bar_rounded,
    Icons.wallet_rounded,
    Icons.credit_card_rounded,
    Icons.euro_rounded,
    Icons.wb_sunny_rounded,
    Icons.mode_night_rounded,
    Icons.family_restroom_outlined,
    Icons.lock_rounded,
    Icons.directions_car_rounded,
    Icons.directions_boat_rounded,
    Icons.sports_soccer_rounded,
    Icons.sports_tennis_rounded,
    Icons.music_note_rounded,
    Icons.nightlife_rounded,
    Icons.medication_rounded,
    Icons.access_alarm_rounded,
    Icons.pets_rounded,
    Icons.mood_rounded,
    Icons.info_outline_rounded,
  ];


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
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: _buildIconButtons(context),
            ),
            const SizedBox(height: 20),
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
        icon: Icon(iconData, color: iconColor, size: 35,)
        )
  ];
}


}

