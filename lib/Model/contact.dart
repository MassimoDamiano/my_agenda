import 'package:flutter/material.dart';

class Contact {
  final int id;
  final String name;
  final String lastName;
  final int tel;
  final ValueNotifier<int> cant;

  Contact({
    required this.id,
    required this.name,
    required this.lastName,
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
      Contact(id: this.id, name: this.name,lastName: this.lastName, tel: this.tel, cant: this.cant);

      Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "lastName": lastName,
        "tel": tel,
        "cantidad": cant.value,
      };

  @override
  String toString() {
    int valor = cant.value;
    return '{id: $id,Name: $name, Last Name: $lastName,Tel: $tel ,cantidad: $valor}  \n';
  }

}
