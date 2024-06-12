import 'package:codefremicsapp/Dialogs/error_dialog.dart';
import 'package:codefremicsapp/Dialogs/fill_form.dart';
import 'package:codefremicsapp/Dialogs/success_dialog.dart';
import 'package:codefremicsapp/Widgets/textfield.dart';
import 'package:codefremicsapp/constants/constants.dart';
import 'package:codefremicsapp/views/customer_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Services/create_customer_service.dart';

class CustomerCreationScreen extends StatefulWidget {
  const CustomerCreationScreen({super.key});

  @override
  State<CustomerCreationScreen> createState() => _CustomerCreationScreenState();
}

class _CustomerCreationScreenState extends State<CustomerCreationScreen> {
  final List<String> genderOptions = [
    "Select gender",
    "Male",
    "Female",
    "Other"
  ];
  late final TextEditingController firstNameController;
  late final TextEditingController otherNameController;
  late final TextEditingController mobileController;
  late final TextEditingController emailController;
  late final TextEditingController descriptionController;
  @override
  void initState() {
    firstNameController = TextEditingController();
    otherNameController = TextEditingController();
    mobileController = TextEditingController();
    emailController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  String selectedGender = "Select gender";
  final _formKey = GlobalKey<FormState>();
  Future<void> _createCustomer() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primaryColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        actions: const [],
        elevation: 5,
        backgroundColor: CustomColors.primaryColor,
        centerTitle: true,
        shape: ShapeBorder.lerp(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          1,
        ),
        title: const Text(
          'Creating a Customer',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w300,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildTextFieldArea(
                context,
                controller: firstNameController,
                hint: "Enter Customer First Name",
                validatorText: "First Name",
              ),
              buildTextFieldArea(
                context,
                controller: otherNameController,
                hint: "Enter Customer other names",
                validatorText: "Other Names",
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * .9,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButtonFormField<String>(
                  value: selectedGender,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  items: genderOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedGender = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value == "Select gender") {
                      return 'Please select a gender';
                    }
                    return null;
                  },
                ),
              ),
              buildTextFieldArea(
                context,
                controller: mobileController,
                hint: "Enter Customer Mobile Number",
                validatorText: "Mobile Number",
              ),
              buildTextFieldArea(
                context,
                controller: emailController,
                hint: "Enter Customer email",
                validatorText: "Email",
              ),
              buildTextFieldArea(
                context,
                controller: descriptionController,
                hint: "Enter Customer Description",
                validatorText: "Description",
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: 55,
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.blue,
                ),
                child: TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CustomerListView(),
                        ),
                      );
                      // final CustomerCreateService service =
                      //     CustomerCreateService();
                      // final response = await service.createCustomer(
                      //   firstName: "$firstNameController.text",
                      //   otherNames: "$otherNameController.text",
                      //   gender: selectedGender,
                      //   mobileNumber: "$mobileController.text",
                      //   email: "$emailController.text",
                      //   description: "$descriptionController.text",
                      // );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const CustomerListView(),
                      //   ),
                      // );
                      // print(response);

                      // if (response['success']) {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => const CustomerListView(),
                      //     ),
                      //   );
                      // } else {
                      //   // ScaffoldMessenger.of(context).showSnackBar(
                      //   //   SnackBar(content: Text(response['message'])),
                      //   // );
                      //   showErrorDialog(context, "Not successfull");
                      // }
                    }
                  },
                  child: const Text(
                    "Create Customer",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
