import 'package:contacts_app/model/contact.dart';
import 'package:contacts_app/util/constraints.dart';

class Helper {
  static List<Contacts> getAllContacts() {
    List<Contacts> contactList = contacts.values.toList();
    contactList.sort((a, b) => b.id.compareTo(a.id));
    return contactList;
  }

  static Contacts getContactById(int id) {
    return contacts[id];
  }

  static bool createContact(Contacts contact) {
    try {
      contact.id = getAllContacts().first.id + 1;
      if (contacts.containsKey(contact.id)) {
        return false;
      } else {
        contacts[contact.id] = contact;
      }
      return true;
    } catch (error) {
      return false;
    }
  }

  static bool updateContact(Contacts contact) {
    try {
      if (contacts.containsKey(contact.id)) {
        contacts[contact.id] = contact;
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  static List<Contacts> searchContact(String key) {
    return getAllContacts()
        .where((contacts) =>
            contacts.name.toLowerCase().startsWith(key.toLowerCase()) ||
            contacts.convertOrigin().toLowerCase() == key.toLowerCase())
        .toList();
  }

  static List<Contacts> getFavoriteContact() {
    return getAllContacts().where((contacts) => contacts.isFav).toList();
  }

  static List<Contacts> favoriteContact =
      <Contacts>[].where((element) => element.isFav).toList();

  static bool deleteContact(int id) {
    try {
      if (contacts.containsKey(id)) {
        contacts.remove(id);
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  static Contacts favContact(Contacts contact) {
    try {
      Contacts newContact = Contacts(
        id: getAllContacts().first.id + 1,
        name: "${contact.name} - Favorite",
        address: contact.address,
        number: contact.number,
        email: contact.email,
        image: contact.image,
        origin: contact.origin,
      );
      if (contacts.containsKey(newContact.id)) {
        return null;
      } else {
        contacts[newContact.id] = newContact;
        return newContact;
      }
    } catch (error) {
      return null;
    }
  }
}
