import 'dart:convert';

import 'package:catatan_harian_bps/src/services/auth_services.dart';
import 'package:catatan_harian_bps/src/views/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../services/session.dart';

class InputTargetKegiatan extends StatefulWidget {
  @override
  _InputTargetKegiatanState createState() => _InputTargetKegiatanState();
}

class _InputTargetKegiatanState extends State<InputTargetKegiatan> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _namaKegiatanController = TextEditingController();
  TextEditingController _tanggalController = TextEditingController();
  TextEditingController _targetController = TextEditingController();
  DateTime _tanggalTerpilih = DateTime.now();
  String? _tempNamaKegiatan;
  String? _tempTanggal;
  String? _tempTarget;
  DateTime? _picked;

  Future<void> _pilihTanggal(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _tanggalTerpilih,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _tanggalTerpilih) {
      setState(() {
        _tanggalTerpilih = picked;
        _tanggalController.text =
            DateFormat('dd MMMM yyyy', 'id_ID').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Kegiatan'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _namaKegiatanController,
                decoration: InputDecoration(
                  labelText: 'Nama Kegiatan',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama kegiatan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _tanggalController,
                decoration: InputDecoration(
                  labelText: 'Tanggal',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () => _pilihTanggal(context),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _targetController,
                decoration: InputDecoration(
                  labelText: 'Target',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Target tidak boleh kosong';
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
                    print("object: ${_tanggalController.text}");
                    if (_formKey.currentState!.validate()) {
                      String? token = await SessionManager.getToken();
                      Map<String, dynamic> tokenData =
                          jsonDecode(token.toString());
                      var bearerToken = tokenData['token'];
                      _tempNamaKegiatan = _namaKegiatanController.text;
                      // _tempTanggal = DateFormat('yyyy-MM-dd').format(picked);
                      _tempTanggal =
                          DateFormat('yyyy-MM-dd').format(_tanggalTerpilih);
                      _tempTarget = _targetController.text;
                      print("token: $bearerToken");
                      print("nama kegiatan: $_tempNamaKegiatan");
                      print("tanggal kegiatan: $_tempTanggal");
                      print("Target kegiatan: $_tempTarget");
                      final result = await AuthService().addKegiatan(
                          _tempNamaKegiatan!,
                          _tempTanggal!,
                          _tempTarget!,
                          bearerToken!);
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                      // Proses simpan data
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
