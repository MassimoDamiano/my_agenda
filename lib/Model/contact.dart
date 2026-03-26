import 'package:flutter/material.dart';

class Contact {
  final int id;
  final String name;
  final int tel;
  final ValueNotifier<int> cant;

  Contact({
    required this.id,
    required this.name,
    required this.tel,
    required this.cant,
  });

  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return super == other;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;

  Contact copyWith({int? id, String? name, int? tel}) =>
      Contact(id: this.id, name: this.name, tel: this.tel, cant: this.cant);
}
