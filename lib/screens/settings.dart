import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kas/screens/home_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _currentPasswordController = TextEditingController();
  final _newpasswordController = TextEditingController();

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: Colors.deepPurple,
    minimumSize: const Size(450, 30),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
  );

  String currentPassword = '';
  String newPassword = '';
  late bool user;

  final formKey = GlobalKey<FormState>();

  bool _isHidePassword = true;
  bool _isHidePassword2 = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
      _isHidePassword2 = !_isHidePassword2;
    });
  }

  @override
  void initState() {
    super.initState();

    _currentPasswordController.addListener(() {
      setState(() {
        currentPassword = _currentPasswordController.text;
      });
    });
    _newpasswordController.addListener(() {
      setState(() {
        newPassword = _newpasswordController.text;
      });
    });
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.deepPurple[300],
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ganti Password',
                style: TextStyle(fontWeight: FontWeight.w400)),
            const Text('Password Saat Ini'),
            TextFormField(
                controller: _currentPasswordController,
                obscureText: _isHidePassword,
                autofocus: false,
                keyboardType: TextInputType.visiblePassword,
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _togglePasswordVisibility();
                      },
                      child: Icon(
                        _isHidePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: _isHidePassword ? Colors.grey : Colors.blue,
                      ),
                    ),
                    isDense: true,
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
                  if (value != null && value.length > 5) {
                    return null;
                  } else {
                    return 'Enter min. 5 characters';
                  }
                }),
            const SizedBox(
              height: 8,
            ),
            const Text('Password Baru'),
            TextFormField(
                controller: _newpasswordController,
                obscureText: _isHidePassword2,
                autofocus: false,
                keyboardType: TextInputType.visiblePassword,
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _togglePasswordVisibility();
                      },
                      child: Icon(
                        _isHidePassword2
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: _isHidePassword2 ? Colors.grey : Colors.blue,
                      ),
                    ),
                    isDense: true,
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
                  if (value != null && value.length > 5) {
                    return null;
                  } else {
                    return 'Enter min. 5 characters';
                  }
                }),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                  style: raisedButtonStyle,
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(pageBuilder:
                          (context, animation, secondaryAnimation) {
                        return const HomeScreen();
                      }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        final tween = Tween(begin: 0.0, end: 1.0);
                        return FadeTransition(
                            opacity: animation.drive(tween), child: child);
                      }),
                    );
                  },
                  child: Text("Simpan")),
            ),
            Spacer(),
            SizedBox(
              height: 80,
            ),
            Row(
              children: [
                Card(
                    child: Image.asset(
                  "assets/photo.png",
                  width: 80,
                  height: 100,
                )),
                SizedBox(width: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "About This App",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20),
                        )
                      ],
                    ),
                    Row(
                      children: [Text("Aplikasi ini dibuat oleh")],
                    ),
                    Row(
                      children: [Text("Nama : Nurus Laily Aprilia")],
                    ),
                    Row(
                      children: [Text("NIM : 1841720049")],
                    ),
                    Row(
                      children: [Text("Tanggal : 11 September 2022")],
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
