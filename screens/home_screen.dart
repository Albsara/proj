import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'menu_screen.dart'; // Import the MenuScreen

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Fetch categories from Supabase
  Future<List<dynamic>> _getCategories() async {
    try {
      final response = await Supabase.instance.client
          .from('categories')
          .select()
          .execute();
      print("Categories fetched: ${response.data}");
      return response.data;
    } catch (e) {
      print('Error fetching categories: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restaurant Menu')),
      body: FutureBuilder<List<dynamic>>(
        future: _getCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final categories = snapshot.data!;
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(categories[index]['name']),
                onTap: () {
                  // Navigate to MenuScreen when a category is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MenuScreen(
                        category: categories[index]['name'],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
