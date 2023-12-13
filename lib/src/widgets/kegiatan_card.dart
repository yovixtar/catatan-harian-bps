import 'package:flutter/material.dart';
import '../models/kegiatan.dart';
import 'package:intl/intl.dart';

class KegiatanCard extends StatelessWidget {
  final Kegiatan kegiatan;

  KegiatanCard({required this.kegiatan});

  void _showDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text(kegiatan.nama),
          title: Text("kegiatan.nama"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildDetailItem(
                    'Tanggal',
                    DateFormat('dd MMMM yyyy', 'id_ID')
                        // .format(DateTime.parse(kegiatan.tanggal))),
                        .format(DateTime.parse("kegiatan.tanggal"))),
                // _buildDetailItem('Target', kegiatan.target),
                _buildDetailItem('Target', "kegiatan.target"),
                if (kegiatan.terealisasi!)
                  _buildDetailItem('Realisasi', kegiatan.realisasi ?? '-'),
                if (kegiatan.terealisasi!)
                  _buildDetailItem('Keterangan', kegiatan.keterangan ?? '-'),
                // _buildDetailItem('NIP Pencatat', kegiatan.nip_pencatat),
                _buildDetailItem('NIP Pencatat', "kegiatan.nip_pencatat"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Tutup'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd MMMM yyyy', 'id_ID')
        // .format(DateTime.parse(kegiatan.tanggal));
        .format(DateTime.parse("kegiatan.tanggal"));

    return InkWell(
      onTap: () => _showDetailsDialog(context),
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade300, Colors.green.shade100],
              // colors: kegiatan.terealisasi
              //     ? [Colors.green.shade300, Colors.green.shade100]
              //     : [Colors.blue.shade300, Colors.blue.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        // kegiatan.nama,
                        "kegiatan.nama",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        // Implementasi aksi berdasarkan nilai value
                      },
                      itemBuilder: (BuildContext context) {
                        return <PopupMenuEntry<String>>[
                          if (!kegiatan.terealisasi!)
                            PopupMenuItem<String>(
                              value: 'realisasi',
                              child: Row(
                                children: [
                                  Icon(Icons.check_circle, color: Colors.green),
                                  SizedBox(width: 8),
                                  Text('Realisasi'),
                                ],
                              ),
                            ),
                          PopupMenuItem<String>(
                            value: 'hapus',
                            child: Row(
                              children: [
                                Icon(Icons.delete, color: Colors.red),
                                SizedBox(width: 8),
                                Text('Hapus'),
                              ],
                            ),
                          ),
                        ];
                      },
                      icon: Icon(Icons.more_vert),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(formattedDate, style: TextStyle(color: Colors.black)),
                Divider(color: Colors.black),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('Target',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        // child: Text(": " + kegiatan.target),
                        child: Text(": " + "kegiatan.target"),
                      ),
                      if (kegiatan.terealisasi!) ...[
                        Expanded(
                          child: Text('Realisasi',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Expanded(
                          child: Text(': ${kegiatan.realisasi}' ?? '-'),
                        ),
                      ] else ...[
                        Expanded(child: SizedBox()),
                        Expanded(child: SizedBox()),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: 5),
                if (kegiatan.terealisasi!)
                  Text('Keterangan: ${kegiatan.keterangan}',
                      style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
