import 'package:flutter/material.dart';
import 'package:kas/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: Colors.purple,
    minimumSize: const Size(250, 45),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
  );

  String email = '';
  String password = '';
  late bool user;

  final formKey = GlobalKey<FormState>();

  bool _isHidePassword = true;

  void _togglePasswordVisibility(){
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() {
      setState(() {
        email = _emailController.text;
      });
    });
    _passwordController.addListener(() {
      setState(() {
        password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // LoginViewModel modelView = Provider.of<LoginViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: ListView(children: [
              const SizedBox(
                height: 80,
              ),
              Image.asset('assets/logo.png', height: 100, width: 200),
              const SizedBox(
                height: 20,
              ),
              const Text('Email address'),
              TextFormField(
                controller: _emailController,
                cursorColor: Colors.black,
                autofocus: false,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                    // prefixIcon: Icon(Icons.email),
                    // hintText: 'Email Address',
                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
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
                validator: (email) {
                  if (email != null && EmailValidator.validate(email)) {
                    return null;
                  } else {
                    return 'Enter a valid email';
                  }
                },
              ),
              const SizedBox(
                height: 8,
              ),
              const Text('Password'),
              TextFormField(
                  controller: _passwordController,
                  obscureText: _isHidePassword,
                  autofocus: false,
                  keyboardType: TextInputType.visiblePassword,
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap:() {
                          _togglePasswordVisibility();
                        },
                        child: Icon(_isHidePassword ? Icons.visibility_off : Icons.visibility,
                        color: _isHidePassword ? Colors.grey : Colors.blue,),
                        ),    
                        isDense: true,                  
                      contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
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
                height: 16,
              ),
              ElevatedButton(
                style: raisedButtonStyle,
                child: const Text(
                  'Sign In',
                  style: TextStyle(fontFamily: 'OpenSans'),
                ),
                onPressed: () => getButtonLoginCustomer(),
              ),
              const SizedBox(
                height: 100,
              ),
            ]),
          ),
        ),
      ),
    );
  }

  getButtonLoginCustomer() async {
    print('di klik');

    email = _emailController.text;
    password = _passwordController.text;

    if (email == "nuruslaily88@gmail.com" && password == "Nurus123") {
      Navigator.push(
        context,
        PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
          return const HomeScreen();
        }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final tween = Tween(begin: 0.0, end: 1.0);
          return FadeTransition(opacity: animation.drive(tween), child: child);
        }),
      );
    }else{
      final snackBar = SnackBar(
        content: Text("Email / Password Salah"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

}
