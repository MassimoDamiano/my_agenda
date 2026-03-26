import 'package:flutter/material.dart';
import 'package:my_agenda/Providers/provider.dart';
import 'package:my_agenda/widgets/list_contacts.dart';
import 'package:provider/provider.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),

        actions: [
          IconButton(onPressed: (null), icon: Icon(Icons.search)),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(value: "logout", child: Text("Logout")),
            ],
          ),
        ],
      ),
      body: ListContacts(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read()<ContactsProvider>().addContact();
        },
        child: Icon(Icons.plus_one_outlined),
      ),
    );
  }
}
