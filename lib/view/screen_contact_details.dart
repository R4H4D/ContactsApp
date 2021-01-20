import 'dart:io';

import 'package:contacts_app/view/contacts.dart';
import 'package:contacts_app/view/widget/widget_update_contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contacts_app/util/helper.dart';
import 'package:contacts_app/model/contact.dart' as model;
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ContactDetails extends StatefulWidget {
  final int id;
  final Function() onRefresh;
  final Function() onSuccess;

  ContactDetails({this.id, this.onRefresh, this.onSuccess});

  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  List<model.Contacts> contactList = [];

  @override
  void initState() {
    contactList = Helper.getAllContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    model.Contacts contacts = Helper.getContactById(widget.id);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: IconButton(
              icon: Icon(Icons.arrow_back_ios, size: 25),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ContactsDashboard(),
                  ),
                );
              }),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                  return PopupMenuItem<String> (
                    value: choice,
                    child: Text(choice),
                  );
                },
              ).toList();
            },
            //Icons(Icon.more_vert, size: 35), onPressed: () {}),
          ),
        ],
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Container(
                  height: 150.0,
                  width: 150.0,
                  color: Color(0xffFF0E58),
                  child:  Image.network(
                    "${contacts.image}",
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(contacts.name,
                      style: GoogleFonts.encodeSans(
                          fontWeight: FontWeight.w700, fontSize: 25)),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${contacts.address}",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w300, fontSize: 20),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.phone, color: Colors.blue.shade500, size: 30)
                      ],
                    ),
                    SizedBox(width: 25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(contacts.number,
                          style: GoogleFonts.encodeSans(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        SizedBox(height: 5),
                        Text("Mobile Number", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200)),
                      ],
                    ),
                    SizedBox(width: 95),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          foregroundColor: Colors.blue,
                          backgroundColor: Colors.blue.shade50,
                          child: IconButton(
                            icon: Icon(Icons.phone, color: Colors.blue.shade500, size: 20),
                            color: Color(0xFF4096B5),
                            iconSize: 17,
                            onPressed: _callNumber,
                          ),
                        ),
                        SizedBox(width: 15),
                        CircleAvatar(
                          foregroundColor: Colors.blue,
                          backgroundColor: Colors.blue.shade50,
                          child: Icon(
                            Icons.message_outlined, color: Colors.blue.shade500, size: 20),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image(image: AssetImage('assets/images/gmail.png'),
                          height: 25,
                          width: 25,
                        ),
                      ],
                    ),
                    SizedBox(width: 25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(contacts.email,
                          style: GoogleFonts.encodeSans(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        SizedBox(height: 5),
                        Text("Gmail Address", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200),),
                      ],
                    ),
                    SizedBox(width: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          foregroundColor: Colors.red.shade200,
                          backgroundColor: Colors.red.shade50,
                          child: Icon(Icons.mail),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void choiceAction (String choice) {
    if (choice=="Settings") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => UpdateContact(
            onSuccess: () {
              widget.onRefresh();
              setState(() {});
            },
            id: widget.id,
          ),
        ),
      );
    }
    else {
      if (Helper.deleteContact(widget.id)) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Delete Confirmation"),
                content: Text("Are you sure you want to delete this contact?"),
                actions: [
                  FlatButton(
                      child: Text("Yes"),
                      onPressed: () {
                        Navigator.of(context).pop();
                        widget.onRefresh();
                      },
                  ),
                  FlatButton(
                      child: Text("No"),
                      onPressed: () {
                      },
                  ),
                ],
              );
            });
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Something went wrong!"),
          ),
        );
      }
    }
  }
}

class Constants {
  static const String Settings = "Edit";
  static const String Subscribe = "Delete";

  static const List<String> choices = <String> [
    Settings, Subscribe
  ];
}

_callNumber() async{
  const number = '01521497710'; //set the number here
  bool res = await FlutterPhoneDirectCaller.callNumber(number);
}
