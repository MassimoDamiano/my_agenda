import 'package:flutter/material.dart';
import 'package:my_agenda/Providers/login_provider.dart';
import 'package:my_agenda/Providers/provider.dart';
import 'package:my_agenda/widgets/addContactForm.dart';
import 'package:my_agenda/widgets/list_contacts.dart';
import 'package:provider/provider.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ContactsProvider>().cargarContacts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),

        actions: [
          IconButton(onPressed: (null), icon: Icon(Icons.search)),
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == "logout") {
                await context.read<LoginProvider>().logout();

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: "logout", child: Text("Logout")),
            ],
          ),
        ],
      ),
      body: ListContacts(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const Addcontactform(),
          );
        },
        child: Icon(Icons.plus_one_outlined),
      ),
    );
  }
}
