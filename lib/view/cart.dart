import 'package:assone/model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:assone/controller/cart_controller.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartController _controller = CartController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: StreamBuilder(
        stream: _controller.getCartItems(),
        builder:
            (BuildContext context, AsyncSnapshot<List<CartItem>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No items in the cart.'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              CartItem item = snapshot.data![index];
              return ListTile(
                leading: Image.network(
                  item.img,
                  width: 50,
                  height: 50,
                ),
                title: Text(item.name),
                subtitle: Text('\$${item.price}'),
              );
            },
          );
        },
      ),
    );
  }
}
