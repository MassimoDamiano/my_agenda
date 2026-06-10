import 'package:flutter/material.dart';
import 'package:my_agenda/Model/contact.dart';
import 'package:my_agenda/Providers/provider.dart';
import 'package:provider/provider.dart';

class Addcontactform extends StatefulWidget {
  final Contact? contact;

  const Addcontactform({super.key, this.contact});

  @override
  State<Addcontactform> createState() => _AddcontactformState();
}

class _AddcontactformState extends State<Addcontactform> {
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _telController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _genderController = TextEditingController();

  Contact get _contact => Contact(
    id: widget.contact?.id ?? 0,
    name: _nameController.text,
    lastName: _lastNameController.text,
    tel: int.tryParse(_telController.text) ?? 0,
    email: _emailController.text,
    address: _addressController.text,
    birthDate: DateTime.tryParse(_birthDateController.text),
    gender: _genderController.text,
    userId: widget.contact?.userId ?? 0,
    cant: ValueNotifier<int>(1),
  );

  bool get _isEditing => widget.contact != null;

  @override
  void initState() {
    super.initState();

    final contact = widget.contact;
    if (contact != null) {
      _nameController.text = contact.name;
      _lastNameController.text = contact.lastName;
      _telController.text = contact.tel.toString();
      _emailController.text = contact.email;
      _addressController.text = contact.address;
      _birthDateController.text =
          contact.birthDate?.toIso8601String().split('T').first ?? '';
      _genderController.text = contact.gender;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _telController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _birthDateController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEditing ? "Edit Contact" : "Add Contact"),
      content: SingleChildScrollView(
        child: Column(
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
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: "Domicilio"),
            ),
            TextField(
              controller: _birthDateController,
              decoration: const InputDecoration(
                labelText: "Fecha nacimiento",
                hintText: "yyyy-mm-dd",
              ),
            ),
            TextField(
              controller: _genderController,
              decoration: const InputDecoration(labelText: "Genero"),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () async {
            final provider = context.read<ContactsProvider>();

            if (_isEditing) {
              await provider.updateContact(_contact);
            } else {
              await provider.addContact(_contact);
            }

            if (!context.mounted) return;
            Navigator.of(context).pop();
          },
          child: Text(_isEditing ? "Save" : "Add"),
        ),
      ],
    );
  }
}
