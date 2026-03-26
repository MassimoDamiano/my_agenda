import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_agenda/Providers/provider.dart';
import 'package:my_agenda/Model/contact.dart';

class ListContacts extends StatelessWidget {
  const ListContacts({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔥 Escucha el provider completo
    final provider = context.watch<ContactsProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Expanded(
            child: provider.items.isEmpty
                ? const Center(
                    child: Text(
                      "No hay contactos",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: provider.items.length,
                    itemBuilder: (context, index) {
                      final Contact contact = provider.items[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 5,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(contact.name[0].toUpperCase()),
                          ),
                          title: Text(contact.name),
                          subtitle: Text("Tel: ${contact.tel}"),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              provider.removeContact(contact);
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
