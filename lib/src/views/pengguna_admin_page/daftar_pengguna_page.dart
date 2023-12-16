import 'package:catatan_harian_bps/src/views/pengguna_admin_page/tambah_pengguna_page.dart';
import 'package:flutter/material.dart';
import 'package:catatan_harian_bps/src/services/auth_services.dart';
import 'package:catatan_harian_bps/src/models/pengguna.dart';
import 'package:catatan_harian_bps/src/widgets/pengguna_card.dart';

class DaftarPengguna extends StatefulWidget {
  @override
  _DaftarPenggunaState createState() => _DaftarPenggunaState();
}

class _DaftarPenggunaState extends State<DaftarPengguna> {
  List<Pengguna>? daftarPengguna;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Pengguna')),
      body: FutureBuilder<List<Pengguna>?>(
        future: AuthService().getDataUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            daftarPengguna = snapshot.data;
            return PenggunaCard(
              daftarPengguna: daftarPengguna ?? [],
            );
          } else {
            return const Center(child: Text("Tidak Ada Data"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TambahPengguna()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
