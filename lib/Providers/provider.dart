import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:my_agenda/Model/contact.dart';
import 'package:my_agenda/Model/db/contactos_api.dart';

class ContactsProvider extends ChangeNotifier {
  final ContactosApi _api = ContactosApi();
  List<Contact> _contacts = [];
  bool _isLoading = false;

  UnmodifiableListView<Contact> get items => UnmodifiableListView(_contacts);
  bool get isLoading => _isLoading;

  Set<Contact> contactSelected = {};

  int get cantContacts => _contacts.length;

  Future<void> cargarContacts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _contacts = await _api.obtenerTodos();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addContact(Contact contact) async {
    final creado = await _api.agregar(contact);
    _contacts.add(creado);
    notifyListeners();
  }

  Future<void> updateContact(Contact contact) async {
    final editado = await _api.editar(contact);
    final index = _contacts.indexWhere((c) => c.id == editado.id);

    if (index != -1) {
      _contacts[index] = editado;
      notifyListeners();
    }
  }

  Future<void> removeContact(Contact contact) async {
    await _api.eliminar(contact.id);

    _contacts.removeWhere((c) => c.id == contact.id);
    notifyListeners();
  }
}
