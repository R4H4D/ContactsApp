import 'dart:ui';
import 'package:contacts_app/view/favorite.dart';
import 'package:contacts_app/view/widget/widget_insert_contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contacts_app/view/screen_contact_details.dart';
import 'package:contacts_app/util/helper.dart';
import 'package:contacts_app/model/contact.dart' as model;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactsDashboard extends StatefulWidget {
  @override
  _ContactsDashboardState createState() => _ContactsDashboardState();
}

class _ContactsDashboardState extends State<ContactsDashboard> {
  List<model.Contacts> contactList = [];

  @override
  void initState() {
    contactList = Helper.getAllContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Contacts",
          style: GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.w700, fontSize: 25),
        ),
        actions: [
          ActionChip(avatar: Icon(Icons.star_border_sharp), label: Text("Favorites"), onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => Favorite(
                      onSuccess: () {
                        setState(() {
                          contactList = Helper.getFavoriteContact();
                        });
                      },
                    )
                ),
            );
          }),
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
                      fontWeight: FontWeight.w300, fontSize: 17),
                  border: InputBorder.none,
                  prefixIcon: Material(
                    child: Padding(
                      padding: EdgeInsets.only(left: 30.0, right: 5.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.grey.shade400,
                        size: 27,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  model.Contacts contacts = contactList[index];
                  return Padding(
                    padding: EdgeInsets.all(5.0),
                    child: ListTile(
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
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Container(
                          height: 50.0,
                          width: 50.0,
                          color: Color(0xffFF0E58),
                          child:  Image.network(
                            "${contacts.image}",
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(contacts.name,
                          style: GoogleFonts.encodeSans(
                              fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          "${contacts.address}",
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w300, fontSize: 18),
                        ),
                      ),
                      trailing: InkWell(
                        child: IconButton(
                            icon: FaIcon(FontAwesomeIcons.star),
                            iconSize: 20,
                            onPressed: () {
                              setState(() {
                              });
                            },
                        ),
                      ),
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
