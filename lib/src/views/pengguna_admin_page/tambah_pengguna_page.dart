import 'dart:convert';

import 'package:catatan_harian_bps/src/services/auth_services.dart';
import 'package:flutter/material.dart';

import '../../services/session.dart';
import 'daftar_pengguna_page.dart';

class TambahPengguna extends StatefulWidget {
  @override
  _TambahPenggunaState createState() => _TambahPenggunaState();
}

class _TambahPenggunaState extends State<TambahPengguna> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _nipController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _rePasswordController = TextEditingController();
  String? _tempName;
  String? _tempNip;
  String? _tempPass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pengguna'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: 'Nama Pengguna',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama pengguna tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _nipController,
                decoration: InputDecoration(
                  labelText: 'NIP',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'NIP tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _rePasswordController,
                decoration: InputDecoration(
                  labelText: 'Ulangi Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ulangi password tidak boleh kosong';
                  } else if (value != _passwordController.text) {
                    return 'Password tidak cocok';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('Simpan', style: TextStyle(fontSize: 16)),
                  onPressed: () async {
                    String? token = await SessionManager.getToken();
                    Map<String, dynamic> tokenData =
                        jsonDecode(token.toString());
                    var bearerToken = tokenData['token'];
                    _tempName = _namaController.text;
                    _tempNip = _nipController.text;
                    _tempPass = _passwordController.text;

                    if (_formKey.currentState!.validate()) {
                      try {
                        await AuthService().addUser(
                            _tempName!, _tempNip!, _tempPass!, bearerToken!);
                        Navigator.of(context).pop();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DaftarPengguna()),
                        );
                      } catch (e) {
                        print("Error: $e");
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
