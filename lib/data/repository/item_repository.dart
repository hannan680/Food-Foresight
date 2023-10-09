import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_foresight/data/models/item.dart';

class ItemRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addItem(Item item, String userId) async {
    await _firestore.collection('users').doc(userId).collection("items").add({
      ...item.toJson(),
      'timestamp': FieldValue.serverTimestamp(), // Add a timestamp field
    });
  }

  Future<void> updateItem(
      String userId, String itemId, Item updatedItem) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection("items")
        .doc(itemId)
        .update(updatedItem.toJson());
  }

  Future<void> deleteItem(String userId, String itemId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection("items")
        .doc(itemId)
        .delete();
  }

  Stream<List<Item>> getItemsStream(userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection("items")
        .orderBy('timestamp',
            descending: true) // Order by timestamp in descending order
        .snapshots()
        .map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          return Item.fromJson(data, doc.id);
        }).toList();
      },
    );
  }
}
