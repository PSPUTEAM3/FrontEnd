import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hackaton3/datas/api_paths.dart';
import 'package:hackaton3/datas/api_provider.dart';
import 'package:hackaton3/datas/token_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';

Organization organization = Organization();

class Organization {
  Organization({
    this.name = '',
    this.email = '',
    this.password = '',
    this.accessToken = '',
    this.refreshToken = '',
  });
  String name;
  String email;
  String password;
  String accessToken, refreshToken;

  clear() async {
    name = '';
    email = '';
    password = '';
    accessToken = '';
    refreshToken = '';

    Box<dynamic> box = await Hive.openBox('login');
    box.clear();
    // box.close();
  }

  getProfile() async {
    try {
      final Map tokens = await TokenManager.getTokens();
      accessToken = tokens['accessToken'];
      refreshToken = tokens['refreshToken'];
      final response = await ApiProvider.request(ApiPaths.GET_USERNAME);
      print('GET_USERNAME $response');
    } catch (e) {
      if (kDebugMode) print('e $e');
    }
  }

  String toJson() => jsonEncode({
        'username': name,
        'email': email,
        'password': password,
      });

  Organization.fromJson(Map<String, dynamic> json)
      : name = json['username'],
        email = json['email'],
        password = '',
        accessToken = json[''],
        refreshToken = json[''];
}
