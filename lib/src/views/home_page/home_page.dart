import 'package:flutter/material.dart';
import 'package:catatan_harian_bps/src/widgets/kegiatan_card.dart';
import 'package:catatan_harian_bps/src/models/kegiatan.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Kegiatan> kegiatanList = [
      Kegiatan(
        id: 1,
        terealisasi: false,
        tanggal: '2023-11-12',
        target: '3',
        nama: 'Sensur Pertanian',
        nip_pencatat: '12345',
      ),
      Kegiatan(
        id: 2,
        terealisasi: true,
        tanggal: '2023-02-10',
        target: '2',
        nama: 'Sensus Ketenagakerjaan Kabupaten Pemalang dan Pekalongan',
        realisasi: '5',
        keterangan: 'Berjalan lancar',
        nip_pencatat: '12345',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: ListView.builder(
        itemCount: kegiatanList.length,
        itemBuilder: (context, index) {
          return KegiatanCard(kegiatan: kegiatanList[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aksi untuk floating action button
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
