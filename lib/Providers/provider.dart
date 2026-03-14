import 'package:flutter/material.dart';
import 'package:my_agenda/Model/contact.dart';
import 'package:my_agenda/Providers/provider.dart';
import 'dart:collection';

// This provider notiify the widgets who´s listening any change in the application

class Provider extends ChangeNotifier {
  List<Contact> _contacts = [];
  UnmodifiableListView<Contact> get items =>
      UnmodifiableListView<Contact>(_contacts);

  Set<Contact> contactSelected = {};

  List<Contact> contactsSelectedd = [];

  Agenda() {
    generateContacts();
  }

  int get cantContacts => _contacts.length;

  generateContacts() {
    _contacts.add(Contact(id: 1, name: "Massimo", tel: 3512897267));
    _contacts.add(Contact(id: 2, name: "Maximo", tel: 3512896667));
    _contacts.add(Contact(id: 3, name: "Mateo", tel: 3515877267));
  }

  void addContact(Contact contact) {
    contactSelected.add(contact);
    notifyListeners();
  }
  void removeContact(Contact contact) {
    contactSelected.remove(contact);
    notifyListeners();
  }
}
