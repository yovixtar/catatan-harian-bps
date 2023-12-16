import 'dart:convert';

import 'package:catatan_harian_bps/src/views/pengguna_admin_page/daftar_pengguna_page.dart';
import 'package:flutter/material.dart';
import 'package:catatan_harian_bps/src/models/pengguna.dart';

import '../services/auth_services.dart';
import '../services/session.dart';
import '../views/pengguna_admin_page/update_pengguna_page.dart';

class PenggunaCard extends StatefulWidget {
  final List<Pengguna> daftarPengguna;

  PenggunaCard({required this.daftarPengguna});

  @override
  _PenggunaCardState createState() => _PenggunaCardState();
}

class _PenggunaCardState extends State<PenggunaCard> {
  late String _deleteNip;

  void _showDeleteDialog(String nip) {
    setState(() {
      _deleteNip = nip;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return HapusDialog(nip: _deleteNip);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: widget.daftarPengguna.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(widget.daftarPengguna[index].nama.toString()),
              // title: Text("widget.daftarPengguna[index].nama"),
              subtitle: Text(widget.daftarPengguna[index].nip.toString()),
              // subtitle: Text("widget.daftarPengguna[index].nip"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdatePengguna(
                                  nama: widget.daftarPengguna[index].nama!,
                                  nip: widget.daftarPengguna[index].nip!,
                                )),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _showDeleteDialog(widget.daftarPengguna[index].nip!);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class HapusDialog extends StatefulWidget {
  final String nip;

  HapusDialog({required this.nip});

  @override
  _HapusDialogState createState() => _HapusDialogState();
}

class _HapusDialogState extends State<HapusDialog> {
  void _onDelete(BuildContext context) async {
    String? token = await SessionManager.getToken();
    Map<String, dynamic> tokenData = jsonDecode(token.toString());
    var bearerToken = tokenData['token'];
    print(widget.nip);
    String? tempNip = widget.nip;

    try {
      await AuthService().deleteUser(tempNip, bearerToken);

      Navigator.of(context).pop();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DaftarPengguna()),
      );
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Konfirmasi Hapus'),
      content: Text(
          'Apakah Anda yakin ingin menghapus pengguna dengan NIP: ${widget.nip} ?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Batal'),
        ),
        TextButton(
          onPressed: () {
            _onDelete(context);
          },
          child: Text(
            'Hapus',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
