import 'package:contacts_app/view/screen_contact_details.dart';
import 'package:flutter/material.dart';
import 'package:contacts_app/util/constraints.dart';
import 'package:contacts_app/util/helper.dart';
import 'package:contacts_app/model/contact.dart' as model;
import 'package:google_fonts/google_fonts.dart';

class InsertContact extends StatefulWidget {
  final int id;
  final Function() onSuccess;

  InsertContact({this.id, this.onSuccess});

  @override
  _InsertContactState createState() => _InsertContactState();
}

class _InsertContactState extends State<InsertContact> {
  List<model.Contacts> contactList = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  String name;
  String address;
  String number;
  String email;
  String image;
  Origin origin;
  model.Contacts contacts;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        //automaticallyImplyLeading: true,
        title: Text("Create Account",
            style: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.w600, fontSize: 25)),
        actions: [
          IconButton(icon: Icon(Icons.more_vert, size: 35), onPressed: () {}),
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          padding: EdgeInsets.all(16),
          children: [
            Text("Name: "),
            TextFormField(
              validator: (val) => val.isEmpty ? "* required" : null,
              controller: nameController,
            ),
            SizedBox(height: 12),
            Text("Address: "),
            TextFormField(
              validator: (val) => val.isEmpty ? "* required" : null,
              controller: addressController,
            ),
            SizedBox(height: 12),
            Text("Number: "),
            TextFormField(
              validator: (val) => val.isEmpty ? "* required" : null,
              controller: numberController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12),
            Text("Email: "),
            TextFormField(
              validator: (val) => val.isEmpty ? "* required" : null,
              controller: emailController,
            ),
            SizedBox(height: 12),
            Text("Image: "),
            TextFormField(
              validator: (val) => val.isEmpty ? "* required" : null,
              controller: imageController,
            ),
            SizedBox(height: 12),
            Text("Group: "),
            DropdownButtonFormField(
              validator: (value) => value == Origin.None ? "* required" : null,
              hint: Text('Please select one'),
              value: origin,
              onChanged: (newValue) {
                setState(() {
                  origin = newValue;
                });
              },
              items: [
                "Please select one",
                "Family",
                "Schoolmates",
                "BFF",
                "Cousins",
                "Colleague",
                "Acquaintance"
              ].map((item) {
                return DropdownMenuItem(
                    child: new Text(item),
                    value: item.toLowerCase() == "please select one"
                        ? Origin.None
                        : item == "Family"
                            ? Origin.Family
                            : item == "Schoolmates"
                                ? Origin.Schoolmates
                                : item == "BFF"
                                    ? Origin.BFF
                                    : item == "Cousins"
                                        ? Origin.Cousins
                                        : item == "Colleague"
                                            ? Origin.Colleague
                                            : Origin.Acquaintance
                );
              }).toList(),
            ),
            SizedBox(height: 12),
            RaisedButton(
              onPressed: () {
                if (formKey.currentState.validate()) {
                  contacts = model.Contacts(
                    id: Helper.getAllContacts().first.id + 1,
                    name: nameController.text,
                    address: addressController.text,
                    number: numberController.text,
                    email: emailController.text,
                    image: imageController.text,
                    origin: origin,
                  );
                  if (Helper.createContact(contacts)) {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ContactDetails(
                        id: contacts.id,
                        onRefresh: () {
                          setState(() {
                            contactList = Helper.getAllContacts();
                          });
                        },
                        ),
                      ),
                    );
                  } else {
                    print("Insert failed");
                  }
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ContactDetails()));
                }
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
