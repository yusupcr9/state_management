import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:state_management/domain/auth/model/login_response.dart';
import 'package:state_management/presentation/sign_in/sign_in_page.dart';
import 'package:state_management/utils/constants.dart' as constants;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late LoginResponse _loginResponse;
  @override
  void initState() {
    final _data = GetStorage().read(constants.USER_LOCAL_KEY);
    _loginResponse = LoginResponse.fromJson(jsonDecode(_data));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loginResponse.token.toString()),
        actions: [
          IconButton(
              onPressed: () async {
                await GetStorage().erase();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignInPage()));
              },
              icon: Icon(Icons.logout_rounded))
        ],
      ),
    );
  }
}
