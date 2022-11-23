import 'package:flutter/material.dart';
import 'package:flutter_front/views/login.dart';
import '../widgets/adaptive_scaffold.dart';

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

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
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
          const Text(
            "Or if you already have an account login",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name *',
                    // ignore: unnecessary_const
                    icon: const Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Icon(Icons.perm_identity),
                    )),
              ),
              const SizedBox(height: 12),
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
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password *',
                    // ignore: unnecessary_const
                    icon: const Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Icon(Icons.lock),
                    )),
                obscureText: true,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Repeat your password *',
                    // ignore: unnecessary_const
                    icon: const Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Icon(Icons.lock),
                    )),
                obscureText: true,
              )
            ]),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
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
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const Login()));
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
        ],
      ),
    );
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
