import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';
import 'package:state_management/domain/auth/model/login_request.dart';
import 'package:state_management/domain/auth/model/login_response.dart';
import 'package:state_management/infrastructure/auth/auth_repository.dart';
import 'package:state_management/utils/constants.dart' as constants;

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  AuthRepository _authRepository = AuthRepository();

  void signInUser(LoginRequest loginRequest) async {
    emit(AuthLoading());

    try {
      final _data = await _authRepository.SignInUserWithEmailAndPassword(
          loginRequest: loginRequest);

      _data.fold(
        (l) => emit(AuthError(l)),
        (r) => emit(AuthLoginSuccess(r)),
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void saveDataToLocal(LoginResponse data) async {
    emit(AuthLoading());
    try {
      await GetStorage().write(constants.USER_LOCAL_KEY, jsonEncode(data));
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void loadDataFromLocal() async {
    emit(AuthLoading());
    try {
      final _data = await GetStorage().read(constants.USER_LOCAL_KEY);
      LoginResponse result = LoginResponse.fromJson(jsonDecode(_data));
      emit(AuthLoginSuccess(result));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
