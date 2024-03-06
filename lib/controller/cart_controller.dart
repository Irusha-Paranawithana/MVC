import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:assone/model/cart_model.dart';

class CartController {
  final CollectionReference _cartCollection =
      FirebaseFirestore.instance.collection('cart');

  Stream<List<CartItem>> getCartItems() {
    return _cartCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return CartItem(
          name: data['name'] ?? 'No Name',
          img: data['img'] ?? 'Image not available',
          price: data['price'] ?? 0.0,
        );
      }).toList();
    });
  }
}
