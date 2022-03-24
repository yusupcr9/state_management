import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:state_management/infrastructure/auth/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  AuthRepository _authRepository = AuthRepository();

  void signInUser(String email, String password) async {
    emit(AuthLoading());

    try {
      String _data = await _authRepository.SignInUserWithEmailAndPassword(
          email: email, password: password);
      emit(AuthLoginSuccess(_data));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
