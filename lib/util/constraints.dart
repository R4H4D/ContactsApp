import 'package:contacts_app/model/contact.dart';

enum Origin {
  Family,
  Schoolmates,
  BFF,
  Cousins,
  Colleague,
  Acquaintance,
  None,
}

Map<int, Contacts> contacts = {
  1: Contacts(
    id: 1,
    name: "Bristol Makers",
    address: "Gazipur, Dhaka",
    number: "01754625846",
    email: "bristol.makers@gmail.com",
    image: "https://www.gstatic.com/tv/thumb/persons/247026/247026_v9_bb.jpg",
    origin: Origin.Family,
  ),
  2: Contacts(
    id: 2,
    name: "Allison Beaker",
    address: "London, UK",
    number: "01958426731",
    email: "allison.beaker@gmail.com",
    image: "https://www.gstatic.com/tv/thumb/persons/894022/894022_v9_bb.jpg",
    origin: Origin.Schoolmates,
  ),
  3: Contacts(
    id: 3,
    name: "Amanda Mickkel",
    address: "London, UK",
    number: "01521496852",
    email: "amanda.mickkel@gmail.com",
    image: "https://upload.wikimedia.org/wikipedia/commons/0/00/Katy_Perry_and_Greg_%2847870635411%29_%28cropped%29.jpg",
    origin: Origin.Acquaintance,
  ),
  4: Contacts(
    id: 4,
    name: "Abdullah Moshiur",
    address: "Zindabazar, Sylhet",
    number: "01364587592",
    email: "abdullah.mohshiur@gmail.com",
    image: "https://225508-687545-raikfcquaxqncofqfm.stackpathdns.com/wp-content/uploads/2018/06/Nick-Jonas.jpg",
    origin: Origin.BFF,
  ),
  5: Contacts(
    id: 5,
    name: "Adward Christanio",
    address: "32 Saint State, LA",
    number: "01496857231",
    email: "adward.christanio@gmail.com",
    image: "https://pbs.twimg.com/profile_images/1111240772718940160/z9loNMgZ_400x400.jpg",
    origin: Origin.Colleague,
  ),
  6: Contacts(
    id: 6,
    name: "Amilia Elie",
    address: "South Surma, Sylhet",
    number: "01674859623",
    email: "amilia.ellie@gmail.com",
    image: "https://pbs.twimg.com/profile_images/1204204456092397568/sKIKwz3S_400x400.jpg",
    origin: Origin.Cousins,
  ),
};
