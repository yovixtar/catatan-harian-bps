import 'dart:convert';

import 'package:catatan_harian_bps/src/views/home_page/home_page.dart';
import 'package:flutter/material.dart';
import '../models/kegiatan.dart';
import 'package:intl/intl.dart';

import '../services/auth_services.dart';
import '../services/session.dart';
import '../views/realisasi_page/input_realisasi_page.dart';

class KegiatanCard extends StatefulWidget {
  final Kegiatan kegiatan;

  KegiatanCard({required this.kegiatan});

  @override
  _KegiatanCardState createState() => _KegiatanCardState();
}

class _KegiatanCardState extends State<KegiatanCard> {
  void _showDetailsDialog(BuildContext context, Kegiatan kegiatan) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(kegiatan.nama.toString()),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildDetailItem(
                  'Tanggal',
                  DateFormat('dd MMMM yyyy', 'id_ID')
                      .format(DateTime.parse(kegiatan.tanggal!)),
                ),
                _buildDetailItem('Target', kegiatan.target!),
                if (kegiatan.terealisasi != null || kegiatan.terealisasi != "")
                  _buildDetailItem('Realisasi', kegiatan.realisasi ?? '-'),
                if (kegiatan.terealisasi != null || kegiatan.terealisasi != "")
                  _buildDetailItem('Keterangan', kegiatan.keterangan ?? '-'),
                _buildDetailItem('NIP Pencatat', kegiatan.nip_pencatat!),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tutup'),
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
    print("tes id: ${widget.kegiatan.id.runtimeType}");
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("tes 2 id: ${widget.kegiatan.id.runtimeType}");
    return InkWell(
      onTap: () => _showDetailsDialog(context, widget.kegiatan),
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: (widget.kegiatan.terealisasi!)
                  ? [Colors.green.shade300, Colors.green.shade100]
                  : [Colors.blue.shade300, Colors.blue.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.kegiatan.nama!,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    PopupMenuButton<String>(
                      onSelected: (value) async {
                        String? token = await SessionManager.getToken();
                        Map<String, dynamic> tokenData =
                            jsonDecode(token.toString());
                        String bearerToken = tokenData['token'];
                        if (value == "realisasi") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InputRealisasiKegiatan(
                                kegiatan: widget.kegiatan,
                                token: bearerToken,
                              ),
                            ),
                          );
                        } else if (value == "hapus") {
                          try {
                            int? idDelete = widget.kegiatan.id;
                            await AuthService()
                                .deleteKegiatan(idDelete!, bearerToken);
                            // Navigator.of(context).pop();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                            );
                          } catch (e) {
                            print('Error deleting user: $e');
                          }
                        }
                        // Implementasi aksi berdasarkan nilai value
                      },
                      itemBuilder: (BuildContext context) {
                        return <PopupMenuEntry<String>>[
                          if (widget.kegiatan.terealisasi!)
                            const PopupMenuItem<String>(
                              value: 'hapus',
                              child: Row(
                                children: [
                                  Icon(Icons.delete, color: Colors.red),
                                  SizedBox(width: 8),
                                  Text('Hapus'),
                                ],
                              ),
                            )
                          else
                            const PopupMenuItem<String>(
                              value: 'realisasi',
                              child: Row(
                                children: [
                                  Icon(Icons.check_circle, color: Colors.green),
                                  SizedBox(width: 8),
                                  Text('Realisasi'),
                                ],
                              ),
                            ),
                          if (!widget.kegiatan.terealisasi!)
                            const PopupMenuItem<String>(
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
                      icon: const Icon(Icons.more_vert),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  DateFormat('dd MMMM yyyy', 'id_ID')
                      .format(DateTime.parse(widget.kegiatan.tanggal!)),
                  style: const TextStyle(color: Colors.black),
                ),
                const Divider(color: Colors.black),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Target',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(": " + widget.kegiatan.target!),
                      ),
                      const Expanded(
                        child: Text(
                          'Realisasi',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          ': ${widget.kegiatan.realisasi == null || widget.kegiatan.realisasi == "" ? '-' : widget.kegiatan.realisasi}',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                if (widget.kegiatan.terealisasi!)
                  Text(
                    'Keterangan: ${widget.kegiatan.keterangan}',
                    style: const TextStyle(color: Colors.black),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
