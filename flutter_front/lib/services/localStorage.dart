import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class StorageAparcam extends ChangeNotifier {
  final LocalStorage storage = LocalStorage('user');

  void addItemsToLocalStorage(String token, String id, String password) {
    storage.setItem('token', token);
    storage.setItem('id', id);
    storage.setItem('password', password);

    //        FORMAT LLISTA SET ITEM

    /* final user = json.encode({'email': email, 'id': id});
    storage.setItem('user', user);*/
  }

  void addFiltersToLocalStorage(bool filtered, String sortby, double minscore,
      double minprice, double maxprice, String type, String dimensions) {
    storage.setItem('filtered', filtered);
    storage.setItem('sortby', sortby);
    storage.setItem('minscore', minscore);
    storage.setItem('minprice', minprice);
    storage.setItem('maxprice', maxprice);
    storage.setItem('type', type);
    storage.setItem('dimensions', dimensions);
  }

  void setFiltered(bool filtered) {
    storage.setItem('filtered', filtered);
  }

  bool getFiltered() {
    return storage.getItem('filtered');
  }

  String getToken() {
    return storage.getItem('token');
  }

  String getId() {
    return storage.getItem('id');
  }

  String getpass() {
    return storage.getItem('password');
  }

  String getSortby() {
    return storage.getItem('sortby');
  }

  String getType() {
    return storage.getItem('type');
  }

  String getDimensions() {
    return storage.getItem('dimensions');
  }

  double getminScore() {
    return storage.getItem('minscore');
  }

  double getminPrice() {
    return storage.getItem('minprice');
  }

  double getmaxPrice() {
    return storage.getItem('maxprice');
  }

  void deleteToken() {
    storage.deleteItem('token');
  }

  void deleteId() {
    storage.deleteItem('id');
  }

  void getitemFromLocalStorage() {
    //        FORMAT LLISTA GET ITEM

    /* Map<String, dynamic> user = json.decode(storage.getItem('user'));
    final user_email = user['email'];
    final user_id = user['id']; */
  }
}
