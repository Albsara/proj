import 'package:flutter/material.dart';

class OrderSummaryScreen extends StatelessWidget {
  // Receiving cart items dynamically via the constructor
  final List<Map<String, dynamic>> cartItems;

  const OrderSummaryScreen({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    // Calculating the total price
    double totalPrice = cartItems.fold(0, (sum, item) {
      return sum + (item['price'] * item['quantity']);
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Order Summary')),
      body: cartItems.isEmpty
          ? Center(child: Text('Your cart is empty')) // Handling empty cart
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(cartItems[index]['name']),
                        subtitle: Text('\$${cartItems[index]['price']}'),
                        trailing: Text('x${cartItems[index]['quantity']}'),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Total: \$${totalPrice.toStringAsFixed(2)}'),
                ),
              ],
            ),
    );
  }
}
