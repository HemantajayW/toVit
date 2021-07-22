import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class toVitUser {
  String? name;
  String? email;
  String? phone;
  String? id;

  toVitUser(
      {required this.email,
      required this.id,
      required this.name,
      required this.phone});
  toVitUser.fromSnapshot(DataSnapshot snapshot) {
    name = snapshot.value['name'];
    phone = snapshot.value['phone'];
    email = snapshot.value['email'];
    id = snapshot.key;
  }

  String toString() =>
      "name: $name\n email: $email \n phone: $phone \nid: $id\n";
}
