import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../dialog/scheduled_dialog.dart';
import '../components/big_main_button.dart';
import '../dialog/token_dialog.dart';
import '../globals/style.dart';
import '../manager/setup.dart';
import '../components/square_button.dart';
import '../dialog/location_dialog.dart';
import '../dialog/error_dialog.dart';
import '../models/setup.dart';
import '../components/loading.dart';
import '../pages/card_list_page.dart';

class SetupForm extends StatefulWidget {
  final Setup? setup;
  const SetupForm(this.setup, {super.key});

  @override
  SetupFormState createState() {
    return SetupFormState();
  }
}

class SetupFormState extends State<SetupForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  void updateFields() {
    if (widget.setup != null) {
      _tokenController.text = widget.setup!.token;
      _latitudeController.text = widget.setup!.latitude;
      _longitudeController.text = widget.setup!.longitude;
    } else {
      _tokenController.text = lastValidToken();
    }
  }

  @override
  Widget build(BuildContext context) {
    updateFields();
    return Form(
      key: _formKey,
      child: Expanded(
        child: Column(
          children: [
            const Spacer(),
            inputBlock(
              label: "Token",
              hintText: "Key".tr(),
              controller: _tokenController,
              onPress: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const TokenDialog();
                    });
              },
              validator: tokenValidator,
            ),
            const Spacer(),
            inputBlock(
              label: "Latitude",
              hintText: "-25.000",
              textType: const TextInputType.numberWithOptions(decimal: true),
              controller: _latitudeController,
              onPress: () {
                showLocation(context);
              },
              validator: locationValidator,
            ),
            const Spacer(),
            inputBlock(
              label: "Longitude",
              hintText: "25.000",
              onPress: () async {
                showLocation(context);
              },
              textType: const TextInputType.numberWithOptions(decimal: true),
              validator: locationValidator,
              controller: _longitudeController,
            ),
            const Spacer(),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: BigMainButton(
                  text: "Add".tr(),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Setup setup = Setup(
                        token: _tokenController.text,
                        latitude: _latitudeController.text
                            .replaceAll(RegExp(r','), '.'),
                        longitude: _longitudeController.text
                            .replaceAll(RegExp(r','), '.'),
                      );

                      showLoading(context);

                      saveSetup(
                        setup,
                      ).then((responseSetup) {
                        popLoading(context);
                        if (responseSetup.statusCode == 200) {
                          if (responseSetup.isOnline == false) {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (contextDialog) {
                                  return const ScheduledDialog();
                                });
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const CardListPage()));
                          }
                        } else {
                          showError(
                              message: responseSetup.status, context: context);
                        }
                      });
                    }
                  },
                )),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  showLocation(BuildContext context) async {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return LocationDialog(_tokenController.text);
        });
  }

  tokenValidator(value) {
    if (value == null ||
        value.isEmpty ||
        (RegExp(r'^[A-Za-z0-9_.]+$').hasMatch(value)) == false) {
      return 'Please enter a valid Key'.tr();
    }
    return null;
  }

  locationValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid Number'.tr();
    }
    try {
      double.parse((value.replaceAll(RegExp(r','), '.')).replaceAll(' ', ''));
    } catch (e) {
      return 'Please enter a valid Number'.tr();
    }

    return null;
  }

  Widget inputBlock(
      {required String label,
      required String hintText,
      required Function onPress,
      TextInputType? textType,
      required Function(String? input) validator,
      required TextEditingController controller}) {
    FocusNode myFocusNode = FocusNode();
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        bottom: 16.0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            flex: 12,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: myTextForm(
                textType: textType,
                myFocusNode: myFocusNode,
                label: label,
                hintText: hintText,
                validator: (input) => validator(input),
                controller: controller,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: SquareButton(text: "?", onPressed: onPress),
          ),
        ],
      ),
    );
  }

  TextFormField myTextForm(
      {TextInputType? textType,
      required FocusNode myFocusNode,
      required String label,
      required String hintText,
      required Function(String? input) validator,
      required TextEditingController controller}) {
    return TextFormField(
      keyboardType: textType,
      focusNode: myFocusNode,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle:
            TextStyle(color: myFocusNode.hasFocus ? Colors.blue : Colors.black),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: mainColor, width: 2.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: Colors.white, width: 2.0),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: placeHolderStyle(),
      ),
      validator: (input) => validator(input),
    );
  }
}

showError({required String message, required BuildContext context}) async {
  showDialog(
      context: context,
      builder: (contextDialog) {
        return ErrorDialog(message);
      });
}
