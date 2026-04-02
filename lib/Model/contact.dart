import 'package:flutter/material.dart';

class Contact {
  final int id;
  final String name;
  final String Lastname;
  final int tel;
  final ValueNotifier<int> cant;

  Contact({
    required this.id,
    required this.name,
    required this.Lastname,
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
      Contact(id: this.id, name: this.name,Lastname: this.Lastname, tel: this.tel, cant: this.cant);

      Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "Last Name": Lastname,
        "cantidad": cant.value,
        "tel": tel,
      };

  @override
  String toString() {
    int valor = cant.value;
    return '{id: $id,Name: $name, Last Name: $Lastname, cantidad: $valor}  \n';
  }

}
