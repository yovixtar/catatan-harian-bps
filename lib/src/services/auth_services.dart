import 'dart:convert';

import 'package:catatan_harian_bps/src/models/pengguna.dart';
import 'package:catatan_harian_bps/src/services/session.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String baseUrl = "https://dskripsi.iyabos.com/api";

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
    var responseData = jsonDecode(response.body);
    if (responseData['code'] == 200) {
      var Session = await SessionManager.saveToken(responseData['token']);
      var Data = await SessionManager.saveData(responseData);
      return Pengguna.fromJson(responseData);
    } else {
      throw Exception('Login Gagal');
    }
  }
}
