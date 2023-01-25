import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/parking.dart';
import '../models/user.dart';
import './userServices.dart';
import './localStorage.dart';

class FavoriteProvider extends ChangeNotifier {
  List<Parking> parkings = <Parking>[];

  var user1 = User(
      id: StorageAparcam().getId(),
      name: "",
      password: "",
      email: "",
      myFavorites: [],
      myParkings: [],
      myBookings: [],
      points: 0,
      deleted: false,
      newpassword: "");

  Future<void> getFavorites() async {
    final user = await UserServices().getOneUser(user1);
    if (user != null) {
      for (int i = 0; i < user.myFavorites.length; i++) {
        Parking p = Parking.fromJson(user.myFavorites[i]);
        if (p != null) {
          parkings.add(p);
        }
      }
    }
    notifyListeners();
  }

  DeltoF(Parking parking) async {
    UserServices().DelToFav(parking);
  }

  AddtoF(Parking parking) async {
    UserServices().AddToFav(parking);
  }

  void toggleFavorite(Parking parking) {
    final isExist = parkings.any((p) => p.id == parking.id);
    if (isExist) {
      parkings.removeWhere((p) => p.id == parking.id);
      DeltoF(parking);
    } else {
      parkings.add(parking);
      AddtoF(parking);
    }
    notifyListeners();
  }

  bool isExist(Parking parking) {
    final isExist = parkings.any((p) => p.id == parking.id);
    return isExist;
  }

  static FavoriteProvider of(
    BuildContext context, {
    bool listen = true,
  }) {
    return Provider.of<FavoriteProvider>(
      context,
      listen: listen,
    );
  }
}
