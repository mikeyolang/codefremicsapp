import 'package:flutter/material.dart';

Widget buildTextFieldArea(
  BuildContext context, {
  required TextEditingController controller,
  required String hint,
  required String validatorText,
}) {
  String? validateTextField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter the Customer $validatorText';
    }

    return null;
  }

  return Container(
    height: 50,
    width: MediaQuery.of(context).size.width * .9,
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(5),
    ),
    child: TextFormField(
      validator: validateTextField,
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    ),
  );
}
