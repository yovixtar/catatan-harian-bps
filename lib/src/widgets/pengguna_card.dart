import 'package:flutter/material.dart';
import 'package:catatan_harian_bps/src/models/pengguna.dart';

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
              // title: Text(widget.daftarPengguna[index].nama),
              title: Text("widget.daftarPengguna[index].nama"),
              // subtitle: Text(widget.daftarPengguna[index].nip),
              subtitle: Text("widget.daftarPengguna[index].nip"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Aksi saat tombol edit ditekan
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
  void _onDelete(BuildContext context) {
    Navigator.of(context).pop();
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
