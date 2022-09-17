class KasModel{
  int? id;
  String? name;
  String? tanggal;
  int? nominal;
  String? keterangan;

  // konstruktor versi 1
  KasModel({this.id, this.name, this.tanggal, this.nominal, this.keterangan});

  // konstruktor versi 2: konversi dari Map ke Contact
  KasModel.fromMap(Map<String, dynamic> map) {
        id = map["id"];
        name = map["name"];
        tanggal = map["tanggal"];
        nominal = map["nominal"];
        keterangan = map["keterangan"];
  }

  // konversi dari Contact ke Map
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if(id != null){
      map['id'] = id;
    }
    map['name'] = name;
    map['tanggal'] = tanggal;
    map['nominal'] = nominal;
    map['keterangan'] = keterangan;

    return map;
  }
}