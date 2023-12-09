import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:catatan_harian_bps/src/models/kegiatan.dart';

class InputRealisasiKegiatan extends StatefulWidget {
  final Kegiatan kegiatan; // Asumsikan Kegiatan merupakan model data Anda

  InputRealisasiKegiatan({required this.kegiatan});

  @override
  _InputRealisasiKegiatanState createState() => _InputRealisasiKegiatanState();
}

class _InputRealisasiKegiatanState extends State<InputRealisasiKegiatan> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _realisasiController = TextEditingController();
  TextEditingController _keteranganController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd MMMM yyyy', 'id_ID')
        .format(DateTime.parse(widget.kegiatan.tanggal));

    return Scaffold(
      appBar: AppBar(
        title: Text('Input Realisasi Kegiatan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildDetailKegiatanCard(widget.kegiatan, formattedDate),
              SizedBox(height: 15),
              TextFormField(
                controller: _realisasiController,
                decoration: InputDecoration(
                  labelText: 'Realisasi',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Realisasi tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _keteranganController,
                decoration: InputDecoration(
                  labelText: 'Keterangan',
                ),
                maxLines: 3,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text('Simpan'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Proses simpan data
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailKegiatanCard(Kegiatan kegiatan, String formattedDate) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: kegiatan.terealisasi
                ? [Colors.green.shade300, Colors.green.shade100]
                : [Colors.blue.shade300, Colors.blue.shade100],
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
                      kegiatan.nama,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
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
                      child: Text(": " + kegiatan.target),
                    ),
                    if (kegiatan.terealisasi) ...[
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
              if (kegiatan.terealisasi)
                Text('Keterangan: ${kegiatan.keterangan}',
                    style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
