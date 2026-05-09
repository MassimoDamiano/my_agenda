import 'package:flutter/material.dart';
import 'package:my_agenda/Model/contact.dart';
import 'package:my_agenda/Providers/provider.dart';
import 'package:provider/provider.dart';

class Addcontactform extends StatefulWidget {
  const Addcontactform({super.key});

  @override
  State<Addcontactform> createState() => _AddcontactformState();
}

class _AddcontactformState extends State<Addcontactform> {
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _telController = TextEditingController();

  Contact get _contact => Contact(
    id: 0,
    name: _nameController.text,
    lastName: _lastNameController.text,
    tel: int.tryParse(_telController.text) ?? 0,
    cant: ValueNotifier<int>(1),
  );

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _telController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ContactsProvider>();

    return AlertDialog(
      title: const Text("Add Contact"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: "Name"),
          ),
          TextField(
            controller: _lastNameController,
            decoration: const InputDecoration(labelText: "Last Name"),
          ),
          TextField(
            controller: _telController,
            decoration: const InputDecoration(labelText: "Telefone"),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            provider.addContact(_contact);
            Navigator.of(context).pop();
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}