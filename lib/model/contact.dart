import 'package:flutter/cupertino.dart';
import 'package:contacts_app/util/constraints.dart';

class Contacts {
   int id;
   String name;
   String address;
   String number;
   String email;
   String image;
   Origin origin;
   bool isFav = false;

   Contacts({
     @required this.id,
     @required this.name,
     @required this.address,
     @required this.number,
     @required this.email,
     @required this.image,
     @required this.origin,
     this.isFav,
   });

   toogleFavorite() {
     isFav = !isFav;
   }

   String convertOrigin() {
     switch(origin) {
       case Origin.Family:
         return "Family";
         break;
       case Origin.Schoolmates:
         return "Schoolmates";
         break;
       case Origin.BFF:
         return "BFF";
         break;
       case Origin.Cousins:
         return "Cousins";
         break;
       case Origin.Colleague:
         return "Colleague";
         break;
       case Origin.Acquaintance:
         return "Acquaintance";
         break;
       case Origin.None:
         return null;
         break;
       default:
         return "Unknown";
     }
   }
}