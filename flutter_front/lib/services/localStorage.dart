import 'dart:convert';

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

  String getToken() {
    return storage.getItem('token');
  }

  String getId() {
    return storage.getItem('id');
  }

  void deleteToken() {
    storage.deleteItem('token');
  }

  String getpass() {
    return storage.getItem('password');
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
