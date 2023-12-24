import 'dart:convert';

import 'package:flutter/material.dart';

import '../../services/auth_services.dart';
import '../../services/session.dart';
import 'daftar_pengguna_page.dart';

class UpdatePengguna extends StatefulWidget {
  final String nama;
  final String nip;

  UpdatePengguna({required this.nama, required this.nip});

  @override
  _UpdatePenggunaState createState() => _UpdatePenggunaState();
}

class _UpdatePenggunaState extends State<UpdatePengguna> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _rePasswordController = TextEditingController();
  String? _tempPass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Pengguna'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, '/admin');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nama Pengguna',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.nama,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'NIP',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.nip,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password Baru',
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
                        labelText: 'Ulangi Password Baru',
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
                          _tempPass = _passwordController.text;
                          String? _tempNip = widget.nip;
                          if (_formKey.currentState!.validate()) {
                            try {
                              await AuthService().changePass(
                                  _tempNip!, _tempPass!, bearerToken!);
                              // Tampilkan pesan keberhasilan kepada pengguna
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Kata sandi berhasil diubah'),
                                  duration: Duration(seconds: 4),
                                ),
                              );
                              Navigator.of(context).pop();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DaftarPengguna()),
                              );
                            } catch (e) {
                              // Tampilkan pesan kesalahan kepada pengguna
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Gagal mengubah kata sandi. Silakan coba lagi.'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
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
          ],
        ),
      ),
    );
  }
}
