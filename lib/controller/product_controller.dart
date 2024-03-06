import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:assone/model/product_model.dart';

class ProductDescriptionController {
  void buyNow(Product product) {
    Map<String, dynamic> orderData = {
      'name': product.name,
      'price': product.price,
      'img': product.imgUrl,
      // You can add additional fields such as quantity, user ID, etc.
    };

    FirebaseFirestore.instance
        .collection('orders')
        .add(orderData)
        .then((value) {
      print('Order placed successfully!');
    }).catchError((error) {
      print('Failed to place order: $error');
    });
  }

  void addToCart(Product product) {
    Map<String, dynamic> cartData = {
      'name': product.name,
      'price': product.price,
      'img': product.imgUrl,
    };

    FirebaseFirestore.instance.collection('cart').add(cartData).then((value) {
      print('Item added to cart successfully!');
    }).catchError((error) {
      print('Failed to add item to cart: $error');
    });
  }
}
