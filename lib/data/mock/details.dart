import 'package:food_foresight/presentation/screens/add_item_screen/model/catogory.dart';

const List<String> quantityType = [
  "other(es)",
  "glass(es)",
  "Jar(s)",
  "Package(s)",
  "Piece(s)",
  "Serving(s)",
  "Bottle(s)",
  "Can(s)",
  "Packet(s)",
  "Carton(s)",
  "Dozen",
  "Pound(s)",
  "Ounce(s)",
  "Gram(s)",
  "Liter(s)",
  "Milliliter(s)",
];
const List<String> inventoryType = ["My freezer", "My fridge", "My pantry"];
const List<String> storageType = [
  "other",
  "Box",
  "Cabinet",
  "Drawer",
  "Room",
  "Shelf",
  "Storage"
];
const List<String> contentType = [
  "other",
  "bag(s)",
  "bottle(s)",
  "baundle(s)",
  "can(s)",
  "gram",
  "jar(s)"
];

const categoryJson = [
  {"name": "Fruit", "image": 'assets/images/catogory_images/fruit.png'},
  {
    "name": "Leaft Overs",
    "image": 'assets/images/catogory_images/leftovers.png'
  },
  {"name": "Vegetable", "image": "assets/images/catogory_images/vegetable.png"},
  {
    "name": "French Fries",
    "image": "assets/images/catogory_images/french-fries.png"
  },
  {"name": "Fish", "image": "assets/images/catogory_images/fish.png"},
  {"name": "Bake", "image": "assets/images/catogory_images/bake.png"}
];

List<Catogory> catogories = categoryJson
    .map((item) => Catogory(name: item['name']!, image: item['image']!))
    .toList();
