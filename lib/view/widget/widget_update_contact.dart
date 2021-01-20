import 'package:flutter/material.dart';
import 'package:contacts_app/util/constraints.dart';
import 'package:contacts_app/util/helper.dart';
import 'package:contacts_app/model/contact.dart' as model;
import 'package:flutter/services.dart';

class UpdateContact extends StatefulWidget {
  final int id;
  final Function() onSuccess;

  UpdateContact({this.id, this.onSuccess});

  @override
  _UpdateContactState createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
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
  void initState() {
    contacts = Helper.getContactById(widget.id);
    nameController.text = contacts.name;
    addressController.text = contacts.address;
    numberController.text = contacts.number;
    emailController.text = contacts.email;
    imageController.text = contacts.image;
    origin = Origin.None;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: true,
        title: Text("Update"),
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
              // Not necessary for Option 1
              value: origin,
              onChanged: (newValue) {
                setState(() {
                  origin = newValue;
                });
              },
              items: ["Please select one", "Family", "Schoolmates", "BFF", "Cousins", "Colleague", "Acquaintance"].map((item) {
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
                contacts.name = nameController.text;
                contacts.address = addressController.text;
                contacts.number = numberController.text;
                contacts.email = emailController.text;
                contacts.image = imageController.text;
                contacts.origin = origin;
                if (Helper.updateContact(contacts)) {
                  widget.onSuccess();
                  Navigator.of(context).pop();
                } else {
                  print("Update failed");
                }
              },
              child: Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}