import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:kas/model/mkas.dart';

import '../model/dbhelper.dart';
import 'home_screen.dart';

class DetailCashFlow extends StatefulWidget {
  const DetailCashFlow({Key? key}) : super(key: key);

  @override
  State<DetailCashFlow> createState() => _DetailCashFlowState();
}

class _DetailCashFlowState extends State<DetailCashFlow> {
  List<Map<String, dynamic>> transaksi = [];

  @override
  void initState() {
    getAllTransaksi();
    super.initState();
  }

  void getAllTransaksi() async {
    final data = await SQLHelper.ambilData();
    setState(() {
      transaksi = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(transaksi);
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Cash Flow"),
        backgroundColor: Colors.deepPurple[300],
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                return const HomeScreen();
              }, transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                final tween = Tween(begin: 0.0, end: 1.0);
                return FadeTransition(
                    opacity: animation.drive(tween), child: child);
              }),
            );
          },
          child: Container(
            padding: const EdgeInsets.only(left: 25),
            child: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
          Radius.circular(18),
        )),
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final kasModel = transaksi[index];
            // String dateFormats = "${kasModel["tanggal"]}";
            //   DateTime parseDate =
            //       new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(dateFormats);
            //   var inputDate = DateTime.parse(parseDate.toString());
            //   var outputFormat = DateFormat('dd MMMM yyyy');
            //   var outputDate = outputFormat.format(inputDate);
            print(kasModel["tanggal"]);
            return Card(
                color: Colors.deepPurple[400],
                child: ListTile(
                  contentPadding: EdgeInsets.all(8),
                  leading: (kasModel["name"] == "pengeluaran")
                      ? Icon(Icons.remove, color: Colors.white)
                      : Icon(Icons.add, color: Colors.white),
                  title: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Rp ${kasModel["nominal"]}',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white)),
                          SizedBox(
                            height: 3,
                          ),
                          Text("${kasModel["keterangan"]}",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                          Text("${kasModel["tanggal"]}",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white)),
                        ],
                      ),
                      Spacer(),
                      Column(children: [
                        (kasModel["name"] == "pengeluaran")
                            ? Icon(Icons.arrow_forward,
                                size: 40, color: Colors.white)
                            : Icon(Icons.arrow_back,
                                size: 40, color: Colors.white)
                      ]),
                    ],
                  ),
                ));
          },
          itemCount: transaksi.length,
        ),
      ),
    );
  }
}
