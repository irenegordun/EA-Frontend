import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_front/services/userServices.dart';
import 'package:flutter_front/views/login.dart';
import 'package:flutter_front/widgets/buttonAccessibility.dart';
import 'package:password_strength_checker/password_strength_checker.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../models/user.dart';
import '../widgets/drawer.dart';
import 'package:flutter_front/services/localStorage.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_front/models/language.dart';
import 'package:flutter_front/models/language_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  User? user;
  File? _image;
  final _picker = ImagePicker();

  deleteU(User user) async {
    var response = await UserServices().deleteUsers(user);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Widget _buttons(BuildContext context, User user) {
    return Center(
        child: ButtonBar(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ButtonTheme(
            minWidth: 200,
            child: ElevatedButton(
              onPressed: () async {
                user = User(
                    name: "",
                    id: StorageAparcam().getId(),
                    password: "",
                    email: "",
                    newpassword: "",
                    points: 0,
                    myFavorites: [],
                    chats: [],
                    myParkings: [],
                    myBookings: [],
                    deleted: false);
                await yousure();
                if (seguro == true) {
                  openDialog("Account deleted correctly!");
                  UserServices().deleteUsers(user);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Login()));
                } else {
                  openDialog("Canceled.");
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const UserInfo()));
                }
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    // Change your radius here
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                backgroundColor:
                    const MaterialStatePropertyAll<Color>(Color.fromARGB(255, 242, 151, 123)),
              ),
              child: const Text('Delete account'),
            )),
      ],
    ));
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => this._image = File(pickedFile.path));
    }
  }
  /*Future _pickImage(ImageSource source) async {
    try{
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    File? img = File(image.path);
    setState((){
      _image = img;
      Navigator.of(context).pop;
    });
    } on PlatformException catch (e){
      print(e);
      Navigator.of(context).pop;
    }

  }*/

  var email = "";
  var newemail = "";
  var name = "";
  var password = "*******";
  bool seguro = false;

  var newpassword = "";
  var isLoaded = false;

  var user1 = User(
      name: "",
      id: StorageAparcam().getId(),
      password: "",
      email: "",
      points: 0,
      myFavorites: [],
      myParkings: [],
      chats: [],
      myBookings: [],
      deleted: false,
      newpassword: "");
  getData() async {
    user = await UserServices().getOneUser(user1);
    if (user != null) {
      setState(() {
        isLoaded = true;
        email = user!.email.toString();
        name = user!.name.toString();
      });
    }
  }

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
              onPressed: submit,
              child: const Text('OK'),
            ),
          ],
        ),
      );

  void submit() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  Future yousure() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Are you sure you want to delete your account"),
          actions: [
            TextButton(
              onPressed: sure,
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: submit,
              child: const Text('No'),
            ),
          ],
        ),
      );

  void sure() {
    seguro = true;
    Navigator.of(context, rootNavigator: true).pop();
  }

  TextEditingController editingController1 = TextEditingController();
  TextEditingController editingController2 = TextEditingController();
  TextEditingController editingController3 = TextEditingController();

  final passNotifier = ValueNotifier<PasswordStrength?>(null);
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~-]).{8,}$');

  @override
  Widget build(BuildContext context) {
    UserServices _userprovider = Provider.of<UserServices>(context);
    return Scaffold(
      drawer: const DrawerScreen(),
      floatingActionButton: const AccessibilityButton(),
      appBar: AppBar(
        title: const Center(
          child: Text("A P A R C A ' M"),
        ),
        backgroundColor: Colors.blueGrey,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<Language>(
              underline: const SizedBox(),
              icon: const Icon(
                Icons.language,
                color: Colors.white,
              ),
              onChanged: (Language? language) async {
                if (language != null) {
                  Locale _locale = await setLocale(language.languageCode);
                  MyApp.setLocale(context, _locale);
                }
              },
              items: Language.languageList()
                  .map<DropdownMenuItem<Language>>(
                    (e) => DropdownMenuItem<Language>(
                      value: e,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            e.flag,
                            style: const TextStyle(fontSize: 30),
                          ),
                          Text(e.name)
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
      body: Center(child: _buildCard(_userprovider.userData)),
    );
  }

  Widget _buildCard(User user) => SizedBox(
        height: 600,
        child: Card(
          child: Column(
            children: [
              ListTile(
                trailing: IconButton(
                  icon: const Icon(Icons.photo),
                  onPressed: () async => _pickImageFromGallery(),
                  tooltip: 'Pick from gallery',
                ),
              ),
              Container(
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade200,
                ),
                child: Center(
                    child: _image == null
                        ? const Text(
                            'No image selected',
                            style: TextStyle(fontSize: 15),
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(_image!),
                            radius: 200.0,
                          )),
              ),
              ListTile(
                title: const Text('email',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle: TextFormField(
                  controller: editingController1,
                  decoration: InputDecoration(hintText: email),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                leading: Icon(
                  Icons.email_outlined,
                  color: Colors.blueGrey,
                ),
                trailing: TextButton(
                    child: const Text("Editar"),
                    onPressed: () async {
                      newemail = editingController1.text;
                      user = User(
                          name: "",
                          id: StorageAparcam().getId(),
                          password: "",
                          email: newemail,
                          newpassword: "",
                          points: 0,
                          myFavorites: [],
                          myParkings: [],
                          chats: [],
                          myBookings: [],
                          deleted: false);
                      if (newemail != "") {
                        if (newemail == email) {
                          openDialog("Alredy your email!");
                        } else {
                          int state = await UserServices().checkemail(user);
                          if (state == 1) {
                            UserServices().updateUseremail(user);
                            openDialog("Email updated correctly!");
                          } else {
                            openDialog(
                                "Can't use this email, belongs to another account!");
                          }
                        }
                      } else {
                        openDialog("Email field is empty!");
                      }

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const UserInfo()));
                    }),
              ),
              ListTile(
                title: Text("Name"),
                //title: Text(translation(context).name),

                subtitle: TextFormField(
                  controller: editingController2,
                  decoration: InputDecoration(hintText: name),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                leading: Icon(
                  Icons.verified_user,
                  color: Colors.blueGrey,
                ),
                trailing: TextButton(
                    child: const Text("Editar"),
                    onPressed: () async {
                      name = editingController2.text;
                      user = User(
                          name: name,
                          id: StorageAparcam().getId(),
                          password: "",
                          email: "",
                          newpassword: "",
                          points: 0,
                          myFavorites: [],
                          chats: [],
                          myParkings: [],
                          myBookings: [],
                          deleted: false);
                      if (name != "") {
                        bool updated =
                            await UserServices().updateUsername(user);
                        if (updated == true) {
                          openDialog("Name updated correctly!");
                        } else {
                          openDialog("Error updating name, please try again.");
                        }
                      } else {
                        openDialog("Name field is empty!");
                      }

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const UserInfo()));
                    }),
              ),
              ListTile(
                title: const Text('Password'),
                subtitle: TextFormField(
                  onChanged: (value) {
                    passNotifier.value =
                        PasswordStrength.calculate(text: value);
                  },
                  controller: editingController3,
                  decoration: InputDecoration(hintText: password),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                leading: Icon(
                  Icons.password,
                  color: Colors.blueGrey,
                ),
                trailing: TextButton(
                    child: const Text("Editar"),
                    onPressed: () async {
                      newpassword = editingController3.text;
                      user = User(
                        name: "",
                        id: StorageAparcam().getId(),
                        password: StorageAparcam().getpass(),
                        email: "",
                        newpassword: newpassword,
                        points: 0,
                        myFavorites: [],
                        myParkings: [],
                        myBookings: [],
                        chats: [],
                        deleted: false,
                      );
                      if (newpassword != "") {
                        if (!regex.hasMatch(newpassword)) {
                          openDialog(
                              'Password too weak, check if you have: 1 uppercase, 1 lowercase, 1 number, 1 special char, at least 8 characters');
                        } else if (await UserServices().updateUserpass(user)) {
                          openDialog("Password updated correctly!");
                        } else {
                          openDialog(
                              "Error updating password, please try again");
                        }
                      } else {
                        openDialog("Password field is empty!");
                      }
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const UserInfo()));
                    }),
              ),
              PasswordStrengthChecker(
                strength: passNotifier,
              ),
              Container(child: _buttons(context, user)),
            ],
          ),
        ),
      );
}
