import 'package:flutter/material.dart';
import 'package:flutter_front/views/Login.dart';
import 'package:flutter_front/views/google_controller.dart';
import '../models/user.dart';
import '../services/userServices.dart';
import '../widgets/adaptive_scaffold.dart';
import 'package:get/get.dart';
import 'package:password_strength_checker/password_strength_checker.dart';

void main() {
  runApp(const Register());
}

class Register extends StatefulWidget {
  const Register({super.key});

  static const welcomeImage = '../assets/welcome.jpg';

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "APARCA'M",
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Center(
        child: AdaptiveScaffold(
          compact: CompactView(
              welcomeImage: Register.welcomeImage, formKey: _formKey),
          full:
              FullView(welcomeImage: Register.welcomeImage, formKey: _formKey),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final nameController = TextEditingController();

  final googlecontroller = Get.put(LoginController());
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final passwordController2 = TextEditingController();
  bool _obscureText = true;

  Future openDialog(String text) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Color.fromARGB(255, 230, 241, 248),
          shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20.0)),
          title: Text ("APARCA'M", style: TextStyle(fontSize: 17)),
          content: Text(text, style: TextStyle(fontSize: 15)),
          actions: [
            TextButton(
              child: Text('Ok'),
              onPressed: submit,
            ),
          ],
        ),
      );

  void submit() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context) {
    final passNotifier = ValueNotifier<PasswordStrength?>(null);
    RegExp regex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~-]).{8,}$');
    return Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Let's create your new account",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 10),
              Form(
                key: widget._formKey,
                child: Column(children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name *',
                        icon: const Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Icon(Icons.perm_identity),
                        )),
                    controller: nameController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email *',
                        icon: const Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Icon(Icons.email),
                        )),
                    controller: emailController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    onChanged: (value) {
                      passNotifier.value =
                          PasswordStrength.calculate(text: value);
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password *',
                        suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              if (_obscureText) {
                                _obscureText = false;
                              } else {
                                _obscureText = true;
                              }
                            });
                          },
                          icon: Icon(_obscureText == true
                              ? Icons.remove_red_eye
                              : Icons.password),
                        ),
                        icon: const Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Icon(Icons.lock),
                        )),
                    obscureText: _obscureText,
                    controller: passwordController,
                  ),
                  const SizedBox(height: 20),
                  PasswordStrengthChecker(
                    strength: passNotifier,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Repeat your password *',
                        suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              if (_obscureText) {
                                _obscureText = false;
                              } else {
                                _obscureText = true;
                              }
                            });
                          },
                          icon: Icon(_obscureText == true
                              ? Icons.remove_red_eye
                              : Icons.password),
                        ),
                        icon: const Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Icon(Icons.lock),
                        )),
                    obscureText: _obscureText,
                    controller: passwordController2,
                  )
                ]),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String formName = nameController.text.toString();
                  String formEmail = emailController.text.toString();
                  String formPassword = passwordController.text.toString();
                  String formPassword2 = passwordController2.text.toString();

                  if (formPassword.isEmpty ||
                      formPassword2.isEmpty ||
                      formEmail.isEmpty ||
                      formName.isEmpty) {
                    openDialog("Please fill the blanks");
                  } else if (!regex.hasMatch(formPassword)) {
                    openDialog(
                        'Password too weak, check if you have: 1 uppercase, 1 lowercase, 1 number, 1 special char, at least 8 characters');
                  } else {
                    if (formPassword == formPassword2) {
                      var user = User(
                        name: formName,
                        id: "",
                        password: formPassword,
                        email: formEmail,
                        newpassword: "",
                        myParkings: [],
                        myFavorites: [],
                        chats: [],
                        myBookings: [],
                        deleted: false,
                        points: 0,
                      );
                      int state = await UserServices().checkemail(user);
                      if (state == 1) {
                        await UserServices().createUser(user);
                        openDialog('User registered, Welcome!');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Login()));
                      } else {
                        openDialog(
                            "Can't use this email, belongs to another account!");
                      }
                    } else {
                      openDialog("Passwords doesn't match");
                    }
                  }

                  setState(() {
                  });
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  minimumSize: const Size(1024, 60),
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  minimumSize: const Size(1024, 50),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                  child: FloatingActionButton.extended(
                onPressed: () async {
                  await googlecontroller.login();
                  var name = googlecontroller.googleAccount.value?.displayName;
                  var email = googlecontroller.googleAccount.value!.email;
                  var user = User(
                      name: name!,
                      id: "",
                      password: "",
                      email: email,
                      newpassword: "",
                      myParkings: [],
                      chats: [],
                      myFavorites: [],
                      myBookings: [],
                      deleted: false,
                      points: 0);
                  int googlestate = await UserServices().registerGoogle(user);
                  if (googlestate == 1) {
                    openDialog('User registered, Welcome!');
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Login()));
                  } else {
                    openDialog('Cannot register, maybe already in database?');
                  }
                },
                label: const Text('Sign up with Google'),
                icon: const Icon(Icons.g_mobiledata_outlined),
                
                backgroundColor: Colors.white,
                foregroundColor: Colors.blueGrey,
              ))
            ],
          ),
        ));
  }
}

class HeroImage extends StatelessWidget {
  const HeroImage({
    Key? key,
    required this.welcomeImage,
  }) : super(key: key);

  final String welcomeImage;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(welcomeImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 24,
          left: 24,
          child: Text(
            "Welcome to APARCA'M",
            maxLines: 2,
            style: textTheme.headline4!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          top: 24,
          left: 24,
          child: Row(
            children: [
              const Icon(
                Icons.car_rental,
                color: Colors.white,
                size: 30,
              ),
              const SizedBox(width: 8),
              Text(
                "APARCA'M",
                maxLines: 2,
                style: textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class CompactView extends StatelessWidget {
  const CompactView({
    Key? key,
    required this.welcomeImage,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final String welcomeImage;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: HeroImage(welcomeImage: welcomeImage),
          ),
          LoginForm(formKey: _formKey),
        ],
      );
    });
  }
}

class FullView extends StatelessWidget {
  const FullView({
    Key? key,
    required this.welcomeImage,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final String welcomeImage;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        children: [
          Flexible(child: LoginForm(formKey: _formKey)),
          Flexible(
            child: HeroImage(welcomeImage: welcomeImage),
          ),
        ],
      );
    });
  }
}
