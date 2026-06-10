import 'package:flutter/material.dart';
import 'package:my_agenda/Model/contact.dart';
import 'package:my_agenda/Providers/provider.dart';
import 'package:my_agenda/widgets/addContactForm.dart';
import 'package:provider/provider.dart';

class ListContacts extends StatelessWidget {
  const ListContacts({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ContactsProvider>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

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
                          title: Text("${contact.name} ${contact.lastName}"),
                          subtitle: Text(
                            "Tel: ${contact.tel}"
                            "\nDomicilio: ${contact.address}"
                            "\nFecha nacimiento: ${contact.birthDate?.toIso8601String().split('T').first ?? ''}"
                            "\nGenero: ${contact.gender}",
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        Addcontactform(contact: contact),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () async {
                                  await provider.removeContact(contact);
                                },
                              ),
                            ],
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
