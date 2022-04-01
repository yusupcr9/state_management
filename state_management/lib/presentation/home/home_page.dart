import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:state_management/domain/auth/model/login_response.dart';
import 'package:state_management/presentation/sign_in/sign_in_page.dart';
import 'package:state_management/utils/constants.dart' as constants;

import '../../application/profile/bloc/profileb_bloc.dart';

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
    return BlocProvider(
      create: (context) => ProfilebBloc()..add(ProfilebEvent.getUsersData()),
      child: BlocConsumer<ProfilebBloc, ProfilebState>(
        listener: (context, state) {
          // TODO: implement listener
          state.maybeMap(
            orElse: () {
              print("ELSE");
            },
            isLoading: (value) {
              print("Is Loading wakwaw");
            },
            isSuccess: (value) {
              print(value.userResponse.toJson());
            },
          );
        },
        builder: (context, state) {
          return state.maybeMap(
              orElse: () => homePageError(),
              isLoading: (e) => homePageLoading(),
              isSuccess: (value) => homePageScaffold(),
              isError: (value) => homePageError());
        },
      ),
    );
  }

  Scaffold homePageError() {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Something wrong"),
              IconButton(onPressed: () {}, icon: Icon(Icons.replay_rounded))
            ],
          ),
        ),
      ),
    );
  }

  Scaffold homePageLoading() =>
      Scaffold(body: Center(child: CircularProgressIndicator()));

  Scaffold homePageScaffold() {
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
      body: Container(
        child: ListView.builder(
          itemBuilder: (context, index) => ListTile(
            title: Text("data"),
          ),
        ),
      ),
    );
  }
}
