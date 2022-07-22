import 'package:flutter/material.dart';

Future<void> displayTextInputDialog(
    BuildContext context, textFieldController, Function(String) func) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Enter Name For Google Form'),
        content: TextField(
          controller: textFieldController,
          decoration: InputDecoration(hintText: "Text Field in Dialog"),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: Text('CANCEL'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          ElevatedButton(
            child: Text('OK'),
            onPressed: () {
              print(textFieldController.text);
              Navigator.pop(context);
              Navigator.pushNamed(context, 'googleformflow',
                  arguments: func(textFieldController.text));
            },
          ),
        ],
      );
    },
  );
}
