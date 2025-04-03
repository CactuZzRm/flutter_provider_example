import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_provider_example/models/item.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class CartProvider extends ChangeNotifier {
  // List<Item> items = [
  //   Item(title: 'Ромашка', price: 10),
  //   Item(title: 'Помидоры', price: 5),
  //   Item(title: 'Лопата', price: 30),
  //   Item(title: 'Тяпка', price: 25),
  //   Item(title: 'Тяпка', price: 75),
  // ];

  List<Item> cart = [];
  List<User> users = [
    User(id: 0, username: null)
  ];
  List<User> selectedUsers = [];

  User user = User(id: -1, username: 'undefind');

  List<User> get getNotSelectedUsers => users.where((element) => !selectedUsers.contains(element)).toList();

  void fetchData() async {
    try {
      final url = 'https://jsonplaceholder.typicode.com/users';
      final urlParse = Uri.parse(url);

      final request = await http.get(urlParse);

      final List<dynamic> jsonList = jsonDecode(request.body);

      users = jsonList.map((element) => User.fromJson(element)).toList();
    } catch (error) {
      throw Exception(error);
    }

    notifyListeners();
  }

  void selectUser(User user) {
    selectedUsers.add(user);

    notifyListeners();
  }

  void addToCart(Item item) {
    cart.add(item);

    notifyListeners();
  }
}
