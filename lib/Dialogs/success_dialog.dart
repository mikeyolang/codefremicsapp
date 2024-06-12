import 'package:codefremicsapp/Dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<bool> showSuccessDialog(
  BuildContext context,
  String text,
) {
  return showGenericErrorDialog(
    context: context,
    title: "Customer Created Successfully",
    content: text,
    optionBuilder: () => {
      "Ok": null,
    },
  ).then(
    (value) => value ?? false,
  );
}
