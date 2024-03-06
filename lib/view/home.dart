import 'package:flutter/material.dart';
import 'package:assone/controller/home_controller.dart';
import 'package:assone/model/home_model.dart';
import 'package:assone/view/product.dart';
import 'package:assone/view/cart.dart';
import 'package:assone/view/order.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Kade'),
        backgroundColor: Colors.green,
      ),
      body: StreamBuilder<List<Item>>(
        stream: HomeController().getItemsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No items available.'));
          }
          return GridView.builder(
            padding: EdgeInsets.all(10.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 0.75,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final item = snapshot.data![index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDescriptionPage(
                        itemName: item.name,
                        itemPrice: item.price.toString(),
                        itemImgUrl: item.img,
                      ),
                    ),
                  );
                },
                child: GridTile(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              item.img,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                'Price: \$${item.price.toString()}',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
            tooltip: 'Cart',
            child: Icon(Icons.shopping_cart),
            backgroundColor: Colors.green,
          ),
          SizedBox(height: 16.0),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FirebaseItemsPage()),
              );
            },
            tooltip: 'My Orders',
            child: Icon(Icons.list),
            backgroundColor: Colors.green,
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
