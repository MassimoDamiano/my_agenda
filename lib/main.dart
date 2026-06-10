import 'package:flutter/material.dart';
import 'package:my_agenda/Providers/login_provider.dart';
import 'package:my_agenda/Providers/contacts_provider.dart';
import 'package:my_agenda/Providers/provider.dart';
import 'package:my_agenda/Screens/contacts.dart';
import 'package:my_agenda/Screens/login.dart';
import 'package:provider/provider.dart';

void main() => runApp((const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => ContactsProvider()),
        ChangeNotifierProvider(create: (context) => CProvider()),
      ],
      child: MaterialApp(
        title: "Contacts",
        debugShowCheckedModeBanner: false,
        home: Selector<LoginProvider, bool>(
          //Utilizamos selector porque buscamos que al recibir un cambio en el login provider
          // solamente llegue al build  cuando sufra un cambio isLoggedIn
          selector: (_, p) =>
              p.isLoggedIn, // verifica si tengo una sesion activa

          builder: (_, isLoggedIn, __) =>
              isLoggedIn ? const Contacts() : const Login(),
        ),
      ),
    );
  }
}
