import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:my_agenda/Providers/login_provider.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: 150.0,
                width: 400.0,
                child: Image.asset('assets/usuario.png'),
              ),
            ),

            Text("My Agenda", style: TextStyle(fontWeight: FontWeight.bold)),

            SizedBox(height: 50),

            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Text("Name"),
            ),

            SizedBox(height: 10),

            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [_textFieldName()],
              ),
            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Text("Password"),
            ),
            SizedBox(height: 10),

            Container(child: _textFieldPassw()),
            SizedBox(height: 80),

            ElevatedButton(
              onPressed: () {
                login(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Iniciar sesión",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                register(context);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Registrarse",
                style: TextStyle(
                  fontSize: 16,
                  color: const Color.fromARGB(255, 3, 3, 3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),

      child: TextField(
        controller: _nameController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _textFieldPassw() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),

      child: TextField(
        controller: _passwordController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Future<void> login(BuildContext context) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    try {
      await loginProvider.login(_nameController.text, _passwordController.text);
    } catch (error) {
      if (!context.mounted) return;

      Flushbar(message: "Error", duration: Duration(seconds: 2)).show(context);
    }
  }

  Future<void> register(BuildContext context) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    try {
      await loginProvider.register(
        _nameController.text,
        _passwordController.text,
      );
      Flushbar(
        message: "Usuario registrado con exito",
        duration: Duration(seconds: 2),
      ).show(context);
    } catch (error) {
      if (!context.mounted) return;

      Flushbar(message: "Error", duration: Duration(seconds: 2)).show(context);
    }
  }
}
