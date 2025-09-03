import 'package:flutter/material.dart';
import 'package:virtual_visiting_card/db/db_helper.dart';
import 'package:virtual_visiting_card/models/contact_model.dart';

class ContactProvider extends ChangeNotifier {
  List<ContactModel> contactList = [];
  final db = DbHelper();
  Future<int> insertContact(ContactModel contactModel) async {
    return db.insertContact(contactModel);
  }

  Future<void> getAllContacts() async {
    contactList = await db.getAllContact();
    notifyListeners();
  }
}
