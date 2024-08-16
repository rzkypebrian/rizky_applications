import 'dart:convert';

import 'package:enerren/util/TypeUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

class FacebookLoginUtil {
  var facebookLogin = FacebookLogin();
  String id;
  String name;
  String firstName;
  String lastName;
  String email;
  String imageUrl;

  void login({
    ValueChanged<FacebookLoginResult> onError,
    ValueChanged<FacebookLoginResult> onCancel,
    ValueChanged2Param<FacebookLoginResult, Map<String, dynamic>> onLoggedIn,
  }) async {
    var facebookLoginResult = await facebookLogin.logIn(['email']);

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        onError(facebookLoginResult);
        break;
      case FacebookLoginStatus.cancelledByUser:
        onCancel(facebookLoginResult);
        break;
      case FacebookLoginStatus.loggedIn:
        var graphResponse = await http.get(Uri(
            scheme:
                'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult.accessToken.token}'));

        var profile = json.decode(graphResponse.body);

        id = profile["id"];
        name = profile["name"];
        firstName = profile["first_name"];
        email = profile["email"];
        imageUrl = profile['picture']['data']['url'];

        onLoggedIn(facebookLoginResult, json.decode(graphResponse.body));

        break;
    }
  }

  Future<void> logout() {
    return facebookLogin.logOut();
  }
}
