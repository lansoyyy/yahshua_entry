import 'package:test_app/utils/const.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  Future<int> loginFunction(String email, String password) async {
    String url = '${ApiConfig().baseUrl}api-auth/';

    var uri = Uri.parse(url);

    var body = {'username': email, 'password': password};

    var response = await http.post(
      body: body,
      uri,
    );

    return response.statusCode;
  }
}
