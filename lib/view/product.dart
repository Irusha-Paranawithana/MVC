import 'package:flutter/material.dart';
import 'package:assone/controller/product_controller.dart';
import 'package:assone/model/product_model.dart';

class ProductDescriptionPage extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final String itemImgUrl;
  final ProductDescriptionController _controller =
      ProductDescriptionController();

  ProductDescriptionPage({
    required this.itemName,
    required this.itemPrice,
    required this.itemImgUrl,
  });

  @override
  Widget build(BuildContext context) {
    final product =
        Product(name: itemName, price: itemPrice, imgUrl: itemImgUrl);

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Description'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(itemImgUrl),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemName,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    itemPrice,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      _controller.buyNow(product);
                    },
                    child: Text('Buy Now'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _controller.addToCart(product);
                    },
                    child: Text('Add To Cart'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
