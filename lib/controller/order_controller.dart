import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:assone/model/order_model.dart';

class FirebaseItemsController {
  late CollectionReference _ordersCollection;

  Stream<List<FirebaseItem>> get itemsStream {
    return _ordersCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return FirebaseItem(
          name: data['name'],
          imageUrl: data['img'],
          price: data['price'],
        );
      }).toList();
    });
  }

  void initStreamListener() {
    _ordersCollection = FirebaseFirestore.instance.collection('orders');
  }
}
