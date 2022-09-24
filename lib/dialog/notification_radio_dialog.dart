import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../components/small_title.dart';
import '../globals/style.dart';
import '../manager/classification.dart';

class NotificationRadioDialog extends StatefulWidget {
  const NotificationRadioDialog({Key? key}) : super(key: key);

  @override
  State<NotificationRadioDialog> createState() =>
      _NotificationRadioDialogState();
}

class _NotificationRadioDialogState extends State<NotificationRadioDialog> {
  final List<Shadow>? shadows = [
    const Shadow(
      blurRadius: 10.0,
      color: Color(0xFF6B7A8B),
      offset: Offset(1.0, 1.0),
    ),
  ];
  final Color? tileColor = const Color(0x59F3F5F7);
  Rating? _character;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: SmallTitle('Notify'.tr()),
      shape: dialogShape(),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RadioListTile(
            title: getTitle('On Update'.tr(), Rating.onUpdate),
            value: Rating.onUpdate,
            groupValue: _character,
            onChanged: (Rating? value) {
              setState(() {
                _character = value;
              });
              Navigator.pop(context, _character);
            },
          ),
          RadioListTile(
            tileColor: tileColor,
            title: getTitle('Good'.tr(), Rating.good),
            value: Rating.good,
            groupValue: _character,
            onChanged: (Rating? value) {
              setState(() {
                _character = value;
              });
              Navigator.pop(context, _character);
            },
          ),
          RadioListTile(
            title: getTitle('Moderate'.tr(), Rating.moderate),
            value: Rating.moderate,
            groupValue: _character,
            onChanged: (Rating? value) {
              setState(() {
                _character = value;
              });
              Navigator.pop(context, _character);
            },
          ),
          RadioListTile(
            tileColor: tileColor,
            title: getTitle('Unhealthy for Sensitive Groups'.tr(), Rating.sensitive),
            value: Rating.sensitive,
            groupValue: _character,
            onChanged: (Rating? value) {
              setState(() {
                _character = value;
              });
              Navigator.pop(context, _character);
            },
          ),
          RadioListTile(
            title: getTitle('Unhealthy'.tr(), Rating.unhealthy),
            value: Rating.unhealthy,
            groupValue: _character,
            onChanged: (Rating? value) {
              setState(() {
                _character = value;
              });
              Navigator.pop(context, _character);
            },
          ),
          RadioListTile(
            tileColor: tileColor,
            title: getTitle('Very Unhealthy'.tr(), Rating.very),
            value: Rating.very,
            groupValue: _character,
            onChanged: (Rating? value) {
              setState(() {
                _character = value;
              });
              Navigator.pop(context, _character);
            },
          ),
          RadioListTile(
            title: getTitle('Hazardous'.tr(), Rating.hazardous),
            value: Rating.hazardous,
            groupValue: _character,
            onChanged: (Rating? value) {
              setState(() {
                _character = value;
              });
              Navigator.pop(context, _character);
            },
          ),
        ],
      ),
    );
  }

  Row getTitle(String text, Rating quality) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(
          text,
          maxLines: 2,
        )),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Container(
            width: 25,
            height: 25,
            color: ratingColor[quality]!,
          ),
        )
      ],
    );
  }
}
