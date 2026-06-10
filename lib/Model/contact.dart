import 'package:flutter/material.dart';

class Contact {
  final int id;
  final String name;
  final String lastName;
  final int tel;
  final String email;
  final String address;
  final DateTime? birthDate;
  final String gender;
  final int userId;
  final ValueNotifier<int> cant;

  Contact({
    required this.id,
    required this.name,
    required this.lastName,
    required this.tel,
    this.email = '',
    this.address = '',
    this.birthDate,
    this.gender = '',
    this.userId = 0,
    required this.cant,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    final telefono = json['telefono'] ?? json['tel'] ?? 0;
    final usuarioId = json['usuarioId'] ?? json['userId'] ?? 0;

    return Contact(
      id: json['id'] ?? 0,
      name: json['nombre'] ?? json['name'] ?? '',
      lastName: json['apellido'] ?? json['lastName'] ?? '',
      tel: int.tryParse(telefono.toString()) ?? 0,
      email: json['email'] ?? '',
      address: json['domicilio'] ?? json['address'] ?? '',
      birthDate: DateTime.tryParse(
        (json['fechaNacimiento'] ?? json['birthDate'] ?? '').toString(),
      ),
      gender: json['genero'] ?? json['gender'] ?? '',
      userId: int.tryParse(usuarioId.toString()) ?? 0,
      cant: ValueNotifier<int>(json['cant'] ?? json['cantidad'] ?? 1),
    );
  }

  Contact copyWith({
    int? id,
    String? name,
    String? lastName,
    int? tel,
    String? email,
    String? address,
    DateTime? birthDate,
    String? gender,
    int? userId,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      tel: tel ?? this.tel,
      email: email ?? this.email,
      address: address ?? this.address,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      userId: userId ?? this.userId,
      cant: cant,
    );
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "lastName": lastName,
    "tel": tel,
    "address": address,
    "birthDate": birthDate?.toIso8601String(),
    "gender": gender,
    "userId": userId,
    "cantidad": cant.value,
  };

  Map<String, dynamic> toJson() => {
    "nombre": name,
    "apellido": lastName,
    "telefono": tel.toString(),
    "email": email,
    "domicilio": address,
    "fechaNacimiento": birthDate?.toIso8601String(),
    "genero": gender,
  };

  @override
  String toString() {
    int valor = cant.value;
    return '{id: $id,Name: $name, Last Name: $lastName,Tel: $tel ,cantidad: $valor}  \n';
  }
}
