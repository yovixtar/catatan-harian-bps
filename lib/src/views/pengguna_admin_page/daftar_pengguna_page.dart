import 'package:flutter/material.dart';
import 'package:catatan_harian_bps/src/models/pengguna.dart';
import 'package:catatan_harian_bps/src/widgets/pengguna_card.dart';

class DaftarPengguna extends StatefulWidget {
  @override
  _DaftarPenggunaState createState() => _DaftarPenggunaState();
}

class _DaftarPenggunaState extends State<DaftarPengguna> {
  List<Pengguna> daftar_pengguna = [
    Pengguna(nama: 'John Doe', nip: '12345', password: "123"),
    Pengguna(nama: 'Jane Smith', nip: '67890', password: "123"),
    // Data pengguna tambahan dapat ditambahkan di sini
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Pengguna')),
      body: PenggunaCard(
        daftarPengguna: daftar_pengguna,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aksi saat tombol tambah ditekan
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
