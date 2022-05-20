import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String> validate;
  final String errortext;
  InputField(
      {@required this.controller,
      this.hintText,
      this.validate,
      this.errortext});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: TextFormField(
        validator: validate,
        controller: controller,
        maxLength: 50,
        maxLines: 2,
        decoration: InputDecoration(
          hoverColor: Colors.blueAccent,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
          hintText: this.hintText,
          hintTextDirection: TextDirection.ltr,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }
}
