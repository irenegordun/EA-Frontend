import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class StorageAparcam extends ChangeNotifier {
  final LocalStorage storage = LocalStorage('user');

  void addItemsToLocalStorage(String token, String id, String password) {
    storage.setItem('token', token);
    storage.setItem('id', id);
    storage.setItem('password', password);
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

  void setSortby(String s) {
    storage.setItem('sortby', s);
  }

  void setType(String s) {
    storage.setItem('type', s);
  }

  void setDimensions(String s) {
    storage.setItem('dimensions', s);
  }

  void setminPrice(int n) {
    storage.setItem('minprice', n);
  }

  void setmaxPrice(int n) {
    storage.setItem('maxprice', n);
  }

  void setminScore(int n) {
    storage.setItem('minscore', n);
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

  void setMapLocation(double latitude, double longitude) {
    storage.setItem('longitude', longitude);
    storage.setItem('latitude', latitude);
  }

  double getLatitude() {
    return storage.getItem('latitude');
  }

  double getLongitude() {
    return storage.getItem('longitude');
  }

  void getitemFromLocalStorage() {
    //        FORMAT LLISTA GET ITEM

    /* Map<String, dynamic> user = json.decode(storage.getItem('user'));
    final user_email = user['email'];
    final user_id = user['id']; */
  }
}
