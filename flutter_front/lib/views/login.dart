import 'package:flutter/material.dart';
import 'package:flutter_front/views/ListParkings.dart';
import 'package:flutter_front/views/register.dart';
import '../widgets/adaptive_scaffold.dart';
import '../models/user.dart';
import '../services/userServices.dart';

import '../services/localStorage.dart';

void main() {
  runApp(const Login());
}

class Login extends StatefulWidget {
  const Login({super.key});

  static const welcomeImage = '../assets/welcome.jpg';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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

  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  bool _obscureText = true;
  bool _activateBool = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Welcome back to APARCA'M",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "Or register if you don't have an account",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          Form(
            key: widget._formKey,
            child: Column(children: [
              TextFormField(
                decoration: const InputDecoration(
                    //dependencies: email_validator: '^2.1.16'
                    border: OutlineInputBorder(),
                    labelText: 'Email *',
                    // ignore: unnecessary_const
                    icon: const Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Icon(Icons.email),
                    )),
                controller: emailController,
              ),
              const SizedBox(height: 12),
              TextFormField(
                obscureText: _obscureText,
                controller: passwordController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
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
              )
            ]),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              String formEmail = emailController.text.toString();

              String formPassword = passwordController.text.toString();

              if (emailController.text.isEmpty) {
                openDialog("Enter your email please");
              } else if (passwordController.text.isEmpty) {
                openDialog("Enter your password please");
              } else {
                var user = User(
                    name: "",
                    id: "",
                    password: formPassword,
                    email: formEmail,
                    newpassword: "",
                    myParkings: [],
                    myFavourites: [],
                    myBookings: [],
                    deleted: false,
                    points: 0);
                int state = await UserServices().loginUser(user);
                if (state == 1) {
                  StorageAparcam().addFiltersToLocalStorage(
                      false, 'none', 0, 0, 1000, 'any', 'any');
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ListParkings()));
                } else if (state == 2) {
                  await activateUser();

                  if (_activateBool == true) {
                    await UserServices().activateUser(user);
                  } else {
                    openDialog(
                        "You did not activate your user, please register another one or, if it was a mistake, press login again");
                  }
                } else {
                  openDialog(
                      'The user does not exist or maybe the password is wrong');
                }
              }
              setState(() {});
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              minimumSize: const Size(1024, 60),
            ),
            child: const Text(
              'Login',
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 5),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Register()));
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              minimumSize: const Size(1024, 50),
            ),
            child: const Text(
              'Register',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Future openDialog(String text) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: submit,
            ),
          ],
        ),
      );

  Future activateUser() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
              "Your user is desactivated do you want to activate it again?"),
          actions: [
            TextButton(
              child: const Text('Yes'),
              onPressed: activate,
            ),
            TextButton(
              child: const Text('No'),
              onPressed: submit,
            ),
          ],
        ),
      );
  void activate() {
    _activateBool = true;

    Navigator.of(context, rootNavigator: true).pop();
  }

  void submit() {
    Navigator.of(context, rootNavigator: true).pop();
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
            height: MediaQuery.of(context).size.height * 0.4,
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
