import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:my_agenda/Model/db/db.dart';
import 'package:my_agenda/Model/contact.dart';

class CProvider extends ChangeNotifier {
  final _db = ContactsDBHelper.instance;

  final List<Contact> _contacts = [];
  bool _isLoading = false;

  UnmodifiableListView<Contact> get contacts => UnmodifiableListView(_contacts);

  bool get isLoading => _isLoading;

  void cargarContacts({String? search}) async {
    _isLoading = true;

    try {
      final list = await _db.getContacts(search: search);
      _contacts
        ..clear()
        ..addAll(list);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Contact?> agregarContact(Contact contact) async {
    final rowId = await _db.insertContact(contact);

    final creado = await _db.getContactById(rowId);

    if (creado != null) {
      _contacts.add(creado);
      notifyListeners();
    }

    return creado;
  }

  Future<bool> actualizarContact(Contact contact) async {
    final affected = await _db.updateContact(contact);

    if (affected > 0) {
      final i = _contacts.indexWhere((p) => p.id == contact.id);
      if (i != -1) {
        _contacts[i] = contact;
        notifyListeners();
      } else {
        //
      }
      return true;
    }
    return false;
  }

  void eliminarContact(int id) async {
    await _db.deleteContact(id);

    _contacts.removeWhere((p) => p.id == id);

    notifyListeners();
  }
}
