import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:state_management/domain/auth/model/login_request.dart';
import 'package:state_management/domain/auth/model/login_response.dart';
import 'package:state_management/domain/core/user/model/user_req_res.dart';
import 'package:state_management/domain/core/user/user_data2.dart';

class UserRepository {
  final Dio _dio = Dio();

  Future<Either<String, UserData2>> createNewUser(
      RequestData requestData) async {
    Response _response;
    String url = "https://reqres.in/api/users";

    try {
      _response = await _dio.post(url, data: requestData.toJson());
      final _result = _response.data;

      return right(UserData2.fromJson(_result));
    } on DioError catch (e) {
      print(e.response!.statusCode);
      String errorMessage = e.response!.data.toString();

      switch (e.type) {
        case DioErrorType.connectTimeout:
          // TODO: Handle this case.
          break;
        case DioErrorType.sendTimeout:
          // TODO: Handle this case.
          break;
        case DioErrorType.receiveTimeout:
          // TODO: Handle this case.
          break;
        case DioErrorType.response:
          // TODO: Handle this case.
          break;
        case DioErrorType.cancel:
          // TODO: Handle this case.
          break;
        case DioErrorType.other:
          // TODO: Handle this case.
          break;
      }
      return left(errorMessage);
    }
  }
}
