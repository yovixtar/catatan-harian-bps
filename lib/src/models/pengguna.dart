class Pengguna {
  String? nama;
  String? nip;
  String? password;
  String? token;

  Pengguna({
    this.nip,
    this.password,
    this.nama,
    this.token,
  });

  Pengguna.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    nip = json['nip'];
    password = json['password'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'nip': nip,
      'password': password,
      'token': token,
    };
  }
}
