import 'package:flutter/material.dart';
import 'package:catatan_harian_bps/src/views/realisasi_page/input_realisasi_page.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:catatan_harian_bps/src/models/kegiatan.dart';

void main() {
  initializeDateFormatting().then((_) {
    runApp(CatatanBPS());
  });
}

class CatatanBPS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catatan Harian BPS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          headline6: TextStyle(color: Colors.blue),
          bodyText2: TextStyle(color: Colors.black87),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          labelStyle: TextStyle(color: Colors.blue),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: InputRealisasiKegiatan(
          kegiatan: Kegiatan(
        id: 1,
        terealisasi: false,
        tanggal: '2023-11-12',
        target: '3',
        nama:
            'Sensur PertanianSensur PertanianSensur PertanianSensur Pertanian',
        nip_pencatat: '12345',
      )),
    );
  }
}
