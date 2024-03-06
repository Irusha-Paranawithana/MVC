import 'package:flutter/material.dart';
import 'package:assone/controller/order_controller.dart';
import 'package:assone/model/order_model.dart';

class FirebaseItemsPage extends StatefulWidget {
  @override
  _FirebaseItemsPageState createState() => _FirebaseItemsPageState();
}

class _FirebaseItemsPageState extends State<FirebaseItemsPage> {
  late FirebaseItemsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FirebaseItemsController();
    _controller.initStreamListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: StreamBuilder<List<FirebaseItem>>(
        stream: _controller.itemsStream,
        builder: (context, snapshot) {
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
          final List<FirebaseItem>? items = snapshot.data;
          if (items == null || items.isEmpty) {
            return Center(
              child: Text('No items available.'),
            );
          }
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                leading: Image.network(
                  item.imageUrl,
                  width: 50,
                  height: 50,
                ),
                title: Text(item.name),
                subtitle: Text('Price: \$${item.price}'),
              );
            },
          );
        },
      ),
    );
  }
}
