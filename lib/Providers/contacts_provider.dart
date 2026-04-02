import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:my_agenda/Model/db/db.dart';
import 'package:my_agenda/Model/contact.dart';

class CProvider extends ChangeNotifier {
  final _db = ContactsDBHelper.instance;

  List<Contact> _contacts = [];
  bool _isLoading = false;

  UnmodifiableListView<Contact> get contacts => UnmodifiableListView(_contacts);
  bool get isLoading => _isLoading;

//Minuto 37 clase 4


  /* void cargarContacts() async {
    _isLoading = true;
    try{
      final list = await _db.getContacts(search: search);
      _contacts..clear()..addAll(list);
    }
    _contacts = await ContactsDBHelper.getContacts();
    notifyListeners();
  } */

 void cargarContacts() async {
    _contacts = await ContactsDBHelper.getContacts();
    notifyListeners();
  }


  void agregarContact(Contact contact) async {
    await ContactsDBHelper.insertContact(contact);
    _contacts.add(contact);
    notifyListeners();
  }

  void actualizarContact(Contact contact) async {
    await ContactsDBHelper.updateContact(contact);
    _contacts[_contacts.indexWhere((p) => p.id == contact.id)] = contact;
    notifyListeners();
  }

  void eliminarContact(int id) async {
    await ContactsDBHelper.deleteContact(id);
    _contacts.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
