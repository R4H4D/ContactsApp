import 'package:contacts_app/util/helper.dart';
import 'package:flutter/material.dart';
import 'package:contacts_app/view/screen_contact_details.dart';
import 'package:contacts_app/view/widget/widget_insert_contact.dart';
import 'package:contacts_app/model/contact.dart' as model;
import 'package:google_fonts/google_fonts.dart';

class Favorite extends StatefulWidget {
  final int id;
  final Function() onSuccess;

  const Favorite({Key key, this.id, this.onSuccess}) : super(key: key);
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  List<model.Contacts> contactList = [];

  @override
  void initState() {
    contactList = Helper.getFavoriteContact();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Favorites",
          style: GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.w700, fontSize: 25),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(Icons.add, size: 35, color: Colors.red.shade200),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => InsertContact(
                      onSuccess: () {
                        setState(() {
                          contactList = Helper.getAllContacts();
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              height: 55,
              child: TextField(
                onChanged: (key) {
                  setState(() {
                    if (key.isNotEmpty) {
                      contactList = Helper.searchContact(key);
                    } else {
                      contactList = Helper.getAllContacts();
                    }
                  });
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Search",
                  hintStyle: GoogleFonts.encodeSansSemiExpanded(
                      fontWeight: FontWeight.w300, fontSize: 15),
                  border: InputBorder.none,
                  prefixIcon: Material(
                    child: Padding(
                      padding: EdgeInsets.only(left: 30.0, right: 5.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.grey.shade400,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(height: 1),
                itemBuilder: (context, index) {
                  model.Contacts contacts = contactList[index];
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ContactDetails(
                            id: contacts.id,
                            onRefresh: () {
                              setState(() {
                                contactList = Helper.getAllContacts();
                              });
                            },
                          ),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      foregroundColor: Colors.deepPurple,
                      backgroundColor: Colors.purple.shade50,
                      child: Hero(
                          tag: "${contacts.id}",
                          child: Text(
                              contacts.name.substring(0, 1).toUpperCase(),
                              style: TextStyle(fontSize: 20))),
                    ),
                    title: Text(contacts.name,
                      style: GoogleFonts.encodeSans(
                          fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    subtitle: Text(
                      "${contacts.address}",
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w300, fontSize: 13),
                    ),
                  );
                },
                itemCount: contactList.length,
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
