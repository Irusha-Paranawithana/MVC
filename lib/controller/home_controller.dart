import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:assone/model/home_model.dart';

class HomeController {
  final CollectionReference _itemsCollection =
      FirebaseFirestore.instance.collection('items');

  Stream<List<Item>> getItemsStream() {
    return _itemsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Item(
          name: data['name'] ?? 'No Name',
          price: data['price'] ?? 0.0,
          img: data['img'] ?? '',
        );
      }).toList();
    });
  }
}
