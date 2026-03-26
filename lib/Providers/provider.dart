import 'package:flutter/material.dart';
import 'package:my_agenda/Model/contact.dart';
import 'dart:collection';

class ContactsProvider extends ChangeNotifier {
  List<Contact> _contacts = [];

  UnmodifiableListView<Contact> get items => UnmodifiableListView(_contacts);

  Set<Contact> contactSelected = {};

  int get cantContacts => _contacts.length;

  // ✅ Constructor correcto
  ContactsProvider() {
    generateContacts();
  }

  void generateContacts() {
    _contacts.add(
      Contact(id: 1, name: "Massimo", tel: 3512897267, cant: ValueNotifier(1)),
    );
    _contacts.add(
      Contact(id: 2, name: "faximo", tel: 3512896667, cant: ValueNotifier(1)),
    );
    _contacts.add(
      Contact(id: 3, name: "gateo", tel: 3515877267, cant: ValueNotifier(1)),
    );
  }

  void addContact(Contact contact) {
    _contacts.add(contact); // 🔥 antes estaba MAL
    notifyListeners();
  }

  void removeContact(Contact contact) {
    _contacts.remove(contact); // 🔥 antes estaba MAL
    notifyListeners();
  }
}
