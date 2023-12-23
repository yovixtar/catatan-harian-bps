import 'package:flutter/material.dart';
import 'package:catatan_harian_bps/src/widgets/kegiatan_card.dart';
import 'package:catatan_harian_bps/src/models/kegiatan.dart';
import '../../services/auth_services.dart';
import '../../services/session.dart';
import '../realisasi_page/input_realisasi_page.dart';
import '../target_page/input_target_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Kegiatan>? daftarKegiatan;

  void _handleLogout() async {
    await SessionManager.clearToken();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        automaticallyImplyLeading: false,
        actions: [
          // Add a logout button to the AppBar
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _handleLogout,
          ),
        ],
      ),
      body: FutureBuilder<List<Kegiatan>?>(
        future: AuthService().getKegiatan(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            daftarKegiatan = snapshot.data;
            // print("tes data kegiatas : ${snapshot}");
            return ListView.builder(
              itemCount: daftarKegiatan!.length,
              itemBuilder: (context, index) {
                return KegiatanCard(kegiatan: daftarKegiatan![index]);
              },
            );
          } else {
            return const Center(child: Text("Tidak Ada Data"));
          }
        },
      ),

      // body: ListView.builder(
      //   itemCount: kegiatanList.length,
      //   itemBuilder: (context, index) {
      //     return KegiatanCard(kegiatan: kegiatanList[index]);
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InputTargetKegiatan()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
