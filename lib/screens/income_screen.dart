import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:kas/model/mkas.dart';
import 'package:kas/screens/detail_cashflow.dart';

import '../model/dbhelper.dart';

class IncomeScreen extends StatefulWidget {
  final KasModel? kasModel;
  IncomeScreen({this.kasModel});

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: Colors.deepPurple,
    minimumSize: const Size(450, 45),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
  );

  final _dateController = TextEditingController();
  final _nominalController = TextEditingController();
  final _keteranganController = TextEditingController();

  String date = '';
  String nominal = '';
  String keterangan = '';

  @override
  void initState() {
    _dateController.addListener(() {
      setState(() {
        date = _dateController.text;
      });
    });
    _nominalController.addListener(() {
      setState(() {
        nominal = _nominalController.text;
      });
    });
    _keteranganController.addListener(() {
      setState(() {
        keterangan = _keteranganController.text;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[300],
          title: Text("Tambah Pemasukan"),
        ),
        body: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Container(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Tanggal',
                        style:
                            TextStyle(color: Color.fromARGB(255, 75, 75, 75)),
                      ),
                      buildDatePicker(context),
                      SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Nominal',
                        style:
                            TextStyle(color: Color.fromARGB(255, 75, 75, 75)),
                      ),
                      TextFormField(
                        controller: _nominalController,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            focusColor: Colors.grey),
                        validator: (value) {
                          if (value != null && value.length > 2) {
                            return null;
                          } else {
                            return 'Masukkan nominal';
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Keterangan',
                        style:
                            TextStyle(color: Color.fromARGB(255, 75, 75, 75)),
                      ),
                      TextFormField(
                        controller: _keteranganController,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            focusColor: Colors.grey),
                        validator: (value) {
                          if (value != null && value.length > 2) {
                            return null;
                          } else {
                            return 'Masukkan keterangan';
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: ElevatedButton(
                            style: raisedButtonStyle,
                            onPressed: () => tambahTransaksi(),
                            child: Text("Simpan")),
                      ),
                    ]))));
  }

  Widget buildDatePicker(BuildContext context) {
    final format = DateFormat("dd/MM/yyyy");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DateTimeField(
          format: format,
          onShowPicker: (context, currentValue) {
            return showDatePicker(
                firstDate: DateTime(1900),
                initialDate: DateTime.now(),
                lastDate: DateTime(DateTime.now().year + 5),
                context: context);
          },
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.calendar_month),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
          ),
          validator: (value) {
            if ((value.toString().isEmpty)) {
              return 'Please Enter Valid Date';
            } else {
              return null;
            }
          },
          onChanged: (value) {
            setState(() => date = value.toString());
          },
        ),
      ],
    );
  }

  tambahTransaksi() async {
    print('klik tambah');
    print(_dateController.text);
    print(date);
    final hasil = await SQLHelper.tambahData('pemasukan', date, _nominalController.text, _keteranganController.text);
    print(hasil);
    Navigator.push(
      context,
      PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
        return DetailCashFlow();
      }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween(begin: 0.0, end: 1.0);
        return FadeTransition(opacity: animation.drive(tween), child: child);
      }),
    );
  }
}
