import 'package:flutter/material.dart';
import 'package:my_agenda/Providers/contacts_provider.dart';
import 'package:my_agenda/Providers/provider.dart';
import 'package:my_agenda/widgets/addContactForm.dart';
import 'package:provider/provider.dart';

class Addcontact extends StatefulWidget {
  const Addcontact({super.key});

  @override
  State<Addcontact> createState() => _AddcontactState();
}

class _AddcontactState extends State<Addcontact> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CProvider>();
    provider.cargarContacts();
    return Scaffold(

     appBar: AppBar(
          title: const Text('Contacts'),
        ),
        body: ListView.builder(
          itemCount: provider.contacts.length,
          itemBuilder: (context, index) {
            final contact = provider.contacts[index];
            return ListTile(
              title: Text(contact.name),
              subtitle: Text('Tel: ${contact.tel}, Cantidad: ${contact.cant.value}'),
              
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(context: context, builder: (context) => const Addcontactform());
          },
        ));


    return const Placeholder();
  }
}
