/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
  */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/application/auth/cubit/auth_cubit.dart';
import 'package:state_management/domain/auth/model/login_request.dart';
import 'package:state_management/presentation/home/home_page.dart';

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text("Error"),
                        content: Text(state.errorMessage),
                      ));
            } else if (state is AuthLoading) {
              print("Loading...");
            } else if (state is AuthLoginSuccess) {
              print(state.dataLogin);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      HomePage(loginResponse: state.dataLogin)));
            }
          },
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.all(20.0),
              color: Colors.grey.shade800,
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ListTile(
                          title: TextField(
                        controller: _emailController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "Email address:",
                            hintStyle: TextStyle(color: Colors.white70),
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.email,
                              color: Colors.white30,
                            )),
                      )),
                      Divider(
                        color: Colors.grey.shade600,
                      ),
                      ListTile(
                          title: TextField(
                        controller: _passwordController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "Password:",
                            hintStyle: TextStyle(color: Colors.white70),
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.lock,
                              color: Colors.white30,
                            )),
                      )),
                      Divider(
                        color: Colors.grey.shade600,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: (state is AuthLoading)
                                ? loginButtonLoading()
                                : loginButton(context),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Forgot your password?',
                        style: TextStyle(color: Colors.grey.shade500),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  ElevatedButton loginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final _requestData = LoginRequest(
          email: _emailController.text,
          password: _passwordController.text,
        );

        context.read<AuthCubit>().signInUser(_requestData);
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.cyan,
      ),
      child: Text(
        'Login',
        style: TextStyle(color: Colors.white70, fontSize: 16.0),
      ),
    );
  }

  ElevatedButton loginButtonLoading() {
    return ElevatedButton(onPressed: null, child: CircularProgressIndicator());
  }
}
