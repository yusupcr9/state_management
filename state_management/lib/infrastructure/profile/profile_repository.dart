import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:state_management/domain/auth/model/login_request.dart';
import 'package:state_management/domain/auth/model/login_response.dart';
import 'package:state_management/domain/core/user/model/user_response.dart';

class ProfileRepository {
  final Dio _dio = Dio();

  Future<Either<String, UserResponse>> getUsersData() async {
    Response _response;
    String url = "https://reqres.in/api/users?page=2";

    try {
      _response = await _dio.get(url);
      UserResponse _userResponse = UserResponse.fromJson(_response.data);
      return right(_userResponse);
    } on DioError catch (e) {
      print(e.response);
      String errorMessage = e.response.toString();

      return left(errorMessage);
    }
  }
}
