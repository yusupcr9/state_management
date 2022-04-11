import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/application/auth/cubit/auth_cubit.dart';
import 'package:state_management/presentation/sign_in/sign_in_page.dart';
import 'package:state_management/presentation/user/user_page.dart';

import '../home/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..loadDataFromLocal(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          print(state.toString());
          if (state is AuthLoginSuccess) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => UserPage()));
          } else if (state is AuthError) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SignInPage()));
          }
        },
        child: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
