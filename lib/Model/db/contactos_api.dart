import 'package:my_agenda/Model/contact.dart';
import 'package:my_agenda/Model/db/api_client.dart';

class ContactosApi {
  Future<List<Contact>> obtenerTodos() async {
    final response = await ApiClient.dio.get('/minimal/contactos');
    final List data = response.data;

    return data
        .map((json) => Contact.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }

  Future<Contact> obtenerPorId(int id) async {
    final response = await ApiClient.dio.get('/api/contacto/$id');

    return Contact.fromJson(Map<String, dynamic>.from(response.data));
  }

  Future<Contact> agregar(Contact contact) async {
    final response = await ApiClient.dio.post(
      '/api/contacto/add',
      data: contact.toJson(),
    );

    return Contact.fromJson(Map<String, dynamic>.from(response.data));
  }

  Future<Contact> editar(Contact contact) async {
    final response = await ApiClient.dio.put(
      '/api/contacto/edit/${contact.id}',
      data: contact.toJson(),
    );

    return Contact.fromJson(Map<String, dynamic>.from(response.data));
  }

  Future<void> eliminar(int id) async {
    await ApiClient.dio.delete('/api/contacto/delete/$id');
  }
}
