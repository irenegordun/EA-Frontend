import 'package:flutter/material.dart';
import 'package:flutter_front/models/user.dart';
import '../services/userServices.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<FormWidget> {
  // String nameValue = '';
  // String passwordValue = '';
  // String emailValue = '';

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Permet accedir al form desde qualseevol lloc

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.account_circle),
            title: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter your name',
              ),
              controller: nameController,

              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              // onSaved: (value) {
              //   nameValue = value!;
              // },
            ),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter your email',
              ),
              controller: emailController,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter your password',
              ),
              controller: passwordController,
              validator: (String? value) {
                // should contain: upepercase, lowercase, digit, spec char, 8 chars
                RegExp regex = RegExp(
                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                } else {
                  if (!regex.hasMatch(value)) {
                    return 'Password too weak, try adding different characters';
                  } else {
                    return null;
                  }
                }
              },
            ),
          ),
          TextButton(
              onPressed: () {
                setState(() async {
                  //aquí dona problemes
                  String formName = nameController.text.toString();
                  String formEmail = emailController.text.toString();
                  String formPassword = passwordController.text.toString();
                  var user = User(
                      name: formName,
                      id: "",
                      password: formPassword,
                      email: formEmail,
                      newpassword: "",
                      myParkings: [],
                      myFavourites: [],
                      myBookings: [],
                      deleted: false,
                      points: 0);

                  await UserServices().createUser(user);
                });
              },
              child: Text('Submit')),
        ],
      ),
    );
  }
}
