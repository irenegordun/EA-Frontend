import 'package:flutter/material.dart';
import 'package:flutter_front/services/userServices.dart';

import '../models/user.dart';

class FormWidgetUpdate extends StatefulWidget {
  const FormWidgetUpdate({super.key});

  @override
  State<FormWidgetUpdate> createState() => _MyStatefulWidgetState();
}

String name = "h";
String email = "h";
String newpass = "h";

updateU(String name, email, newpass) async {
  var user = User(name: name, id: "", password: newpass, email: email);
  bool res = await UserServices().updateUser(user);
  if (res == true) {
    return true;
  } else {
    return false;
  }
}

class _MyStatefulWidgetState extends State<FormWidgetUpdate> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter your new name',
            ),
            validator: (String? name1) {
              if (name1 == null || name1.isEmpty) {
                return 'Please enter a valid name';
              }
              name = name1;
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter your new email',
            ),
            validator: (String? email1) {
              if (email1 == null || email1.isEmpty) {
                return 'Please enter some text';
              }
              email = email1;
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter the new password',
            ),
            validator: (String? newpass1) {
              if (newpass1 == null || newpass1.isEmpty) {
                return 'Please enter some text';
              }
              newpass = newpass1;
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0), //16.0
            child: ElevatedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState!.validate()) {
                  const SnackBar(content: Text('Processing Data'));
                  if (name != 'h' && email != 'h' && newpass != 'h') {
                    bool res = updateU(name, email, newpass) as bool;
                    if (res == false) {
                      ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 255, 0, 0));
                    } else {
                      ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 0, 255, 0));
                    }
                  }
                }
              },
              child: const Text('Update'),
            ),
          ),
        ],
      ),
    );
  }
}
