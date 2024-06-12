import 'package:codefremicsapp/Dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<bool> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericErrorDialog(
    context: context,
    title: "Invalid Credentials",
    content: text,
    optionBuilder: () => {
      "Ok": null,
    },
  ).then(
    (value) => value ?? false,
  );
}
