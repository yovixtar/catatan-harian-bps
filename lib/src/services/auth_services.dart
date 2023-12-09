import 'dart:convert';

import 'package:catatan_harian_bps/src/models/pengguna.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String baseUrl = "http://localhost:8080";

  Future<Pengguna?> login({
    String? nip,
    String? password,
  }) async {
    var response = await http.post(
      Uri.parse(baseUrl + "/login"),
      body: {
        'nip': nip,
        'password': password,
      },
    );
    print("nip - Password : " + nip! + " - " + password!);
    print("code : " + jsonDecode(response.body)['code']);
    if (jsonDecode(response.body)['code'] == 200) {
      print(jsonDecode(response.body));

      return jsonDecode(response.body)['token'];
    } else {
      throw Exception('Gagal Login');
    }
  }
}
