import 'package:dio/dio.dart';

class AuthRepository {
  final Dio _dio = Dio();

  Future<String> SignInUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    Response _response;
    String url = "https://reqres.in/api/login";

    Map<String, dynamic> requestData = {
      "email": email,
      "password": password,
    };
    _response = await _dio.post(url, data: requestData);
    String _result = _response.data.toString();
    return _result;
  }
}
