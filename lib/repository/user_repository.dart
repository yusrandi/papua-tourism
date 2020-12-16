import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:papua_tourism/config/api.dart';
import 'package:papua_tourism/model/result_model.dart';
import 'package:papua_tourism/model/user_model.dart';
import 'package:papua_tourism/service/api_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class UserRepository {
  Future<UserModel> getLogin(
    @required String email,
    @required String password,
  );
  Future<User> getRegister(
    @required String name,
    @required String email,
    @required String password,
  );
}

class UserRepositoryImpl implements UserRepository {
  final TAG = "UserRepositoryImpl";
  @override
  Future<UserModel> getLogin(String email, String password) async {
    var _response = await http.post(Api.instance.loginURL, body: {
      "email": email,
      "password": password,
    });
    print(_response.statusCode);
    if (_response.statusCode == 200) {
      print("$TAG getLogin true");

      var data = json.decode(_response.body);
      UserModel user = UserModel.fromJson(data);
      print(user);
      return user;
    } else {
      print("$TAG getLogin true");
      throw Exception();
    }
  }

  @override
  Future<User> getRegister(String name, String email, String password) async {
    var _response = await http.post(Api.instance.registerURL, body: {
      "email": email,
      "name": name,
      "password": password,
    });
    print(_response.statusCode);
    if (_response.statusCode == 200) {
      print("$TAG getRegister true");

      var data = json.decode(_response.body);
      User user = UserModel.fromJson(data).user;
      print(user);
      return user;
    } else {
      print("$TAG getRegister false");
      throw Exception();
    }
  }
}
