import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/parking.dart';
import '../models/user.dart';
import './userServices.dart';
import './localStorage.dart';

class FavoriteProvider extends ChangeNotifier {
  List<Parking>? parkings = [];

  DeltoF(Parking parking) async {
    UserServices().DelToFav(parking);
  }

  AddtoF(Parking parking) async {
    UserServices().AddToFav(parking);
  }

  void toggleFavorite(Parking parking) {
    final isExist = parkings!.contains(parking);
    if (isExist) {
      parkings!.remove(parking);
      DeltoF(parking);
    } else {
      parkings!.add(parking);
      AddtoF(parking);
    }
    notifyListeners();
  }

  bool isExist(Parking parking) {
    final isExist = parkings!.contains(parking);
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
