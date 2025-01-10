import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'order_summary_screen.dart'; // Import the OrderSummaryScreen

class MenuScreen extends StatefulWidget {
  final String category;

  const MenuScreen({super.key, required this.category});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // This will hold the cart items
  List<Map<String, dynamic>> cartItems = [];

  // Fetch menu items based on the category
  Future<List<dynamic>> _getMenuItems() async {
    final response = await Supabase.instance.client
        .from('menu_items')
        .select()
        .eq('category', widget.category)
        .execute();
    print("Menu items fetched: ${response.data}");
    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu - ${widget.category}')),
      body: FutureBuilder<List<dynamic>>(
        future: _getMenuItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(items[index]['name']),
                subtitle: Text('\$${items[index]['price']}'),
                trailing: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    // Add item to cart
                    setState(() {
                      cartItems.add({
                        'name': items[index]['name'],
                        'price': items[index]['price'],
                        'quantity': 1,
                      });
                    });

                    // Navigate to the Order Summary screen with the cart items
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderSummaryScreen(cartItems: cartItems),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
