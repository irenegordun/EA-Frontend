import 'package:flutter/material.dart';
import 'package:flutter_front/services/userServices.dart';
import 'package:flutter_front/views/login.dart';
import 'package:flutter_front/widgets/buttonAccessibility.dart';
import 'package:password_strength_checker/password_strength_checker.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../widgets/drawer.dart';
import 'package:flutter_front/services/localStorage.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  User? user;
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
                    myFavourites: [],
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
                    const MaterialStatePropertyAll<Color>(Colors.blueGrey),
              ),
              child: const Text('Delete account'),
            )),
      ],
    ));
  }

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
      myFavourites: [],
      myParkings: [],
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
          title: Text(text),
          actions: [
            TextButton(
              onPressed: submit,
              child: const Text('Ok'),
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
        title: const Text('Profile'),
        backgroundColor: Colors.blueGrey,
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
                title: const Text('email',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle: TextFormField(
                  controller: editingController1,
                  decoration: InputDecoration(hintText: email),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                leading: Icon(
                  Icons.email_outlined,
                  color: Colors.blue[500],
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
                          myFavourites: [],
                          myParkings: [],
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
                title: const Text('Name'),
                subtitle: TextFormField(
                  controller: editingController2,
                  decoration: InputDecoration(hintText: name),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                leading: Icon(
                  Icons.verified_user,
                  color: Colors.blue[500],
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
                          myFavourites: [],
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
                  color: Colors.blue[500],
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
                        myFavourites: [],
                        myParkings: [],
                        myBookings: [],
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
