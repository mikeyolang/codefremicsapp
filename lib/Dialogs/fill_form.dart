import 'package:codefremicsapp/Dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<bool> showFillFormDialog(BuildContext context) {
  return showGenericErrorDialog(
      context: context,
      title: "Erro On The Form",
      content: "Kindly make sure you have filled all the form details",
      optionBuilder: () => {
            "Ok": null,
          }).then(
    (value) => value ?? false,
  );
}
