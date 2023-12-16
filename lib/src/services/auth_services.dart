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
      Uri.parse("$baseUrl/login"),
      body: {
        'nip': nip,
        'password': password,
      },
    );
    print("nip - Password : ${nip!} - ${password!}");
    var responseData = jsonDecode(response.body);
    if (responseData['code'] == 200) {
      var Session = await SessionManager.saveToken(responseData['token']);
      var Data = await SessionManager.saveData(responseData);
      return Pengguna.fromJson(responseData);
    } else {
      throw Exception('Login Gagal');
    }
  }

  Future<List<Pengguna>?> getDataUser() async {
    try {
      String? token = await SessionManager.getToken();
      // print("tokens: $token");

      Map<String, dynamic> tokenData = jsonDecode(token.toString());
      var BarearToken = tokenData['token'];

      if (token != null) {
        var response = await http.get(
          Uri.parse("$baseUrl/pengguna"),
          headers: {'Authorization': 'Bearer $BarearToken'},
        );

        var responseData = jsonDecode(response.body);
        // print("dataku: $responseData");

        if (responseData['code'] == 200) {
          List<dynamic> data = responseData['data'];
          List<Pengguna> userList =
              data.map((item) => Pengguna.fromJson(item)).toList();
          print("data: $userList");
          return userList;
        } else {
          throw Exception('Gagal Load Data');
        }
      } else {
        throw Exception('Token tidak tersedia');
      }
    } catch (e) {
      // print(e);
      throw Exception('Gagal mendapatkan token');
    }
  }

  Future<void> addUser(
      String name, String nip, String password, String token) async {
    try {
      var response = await http.post(
        Uri.parse("$baseUrl/pengguna"),
        headers: {'Authorization': 'Bearer $token'},
        body: {
          'nama': name,
          'nip': nip,
          'password': password,
        },
      );
      print("respon body: ${response.body}");
      var responseData = jsonDecode(response.body);
      print("respon data: $responseData");

      if (responseData['code'] == 200) {
        print('Pengguna berhasil ditambahkan');
      } else {
        throw Exception('Gagal menambahkan pengguna baru');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Gagal menambahkan pengguna baru');
    }
  }

  Future<void> changePass(String nip, String password, String token) async {
    try {
      var response = await http.post(
        Uri.parse("$baseUrl/ganti-password"),
        headers: {'Authorization': 'Bearer $token'},
        body: {
          'nip': nip,
          'password-baru': password,
        },
      );
      print("respon body: ${response.body}");
      var responseData = jsonDecode(response.body);
      print("respon data: $responseData");

      if (responseData['code'] == 200) {
        print('Password berhasil diubah');
      } else {
        throw Exception('Gagal mengubah password baru');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Gagal mengubah password baru');
    }
  }

  Future<void> deleteUser(String nip, String token) async {
    try {
      var response = await http.delete(
        Uri.parse("$baseUrl/pengguna/$nip"),
        headers: {'Authorization': 'Bearer $token'},
      );

      var responseData = jsonDecode(response.body);

      if (responseData['code'] == 200) {
        print('Pengguna berhasil dihapus');
      } else {
        throw Exception('Gagal menghapus pengguna');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Gagal menghapus pengguna');
    }
  }
}
