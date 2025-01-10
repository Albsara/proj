import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseApi {
  final SupabaseClient _client;

  // Initialize Supabase client
  SupabaseApi() : _client = Supabase.instance.client;

  // Fetch categories from Supabase
  Future<List<dynamic>> fetchCategories() async {
    try {
      final response = await _client.from('categories').select().execute();
      if (response.error != null) {
        throw response.error!;
      }
      print("Categories fetched: ${response.data}");
      return response.data;
    } catch (e) {
      print('Error fetching categories: $e');
      rethrow;
    }
  }

  // Fetch menu items based on category
  Future<List<dynamic>> fetchMenuItems(String category) async {
    try {
      final response = await _client
          .from('menu_items')
          .select()
          .eq('category', category)
          .execute();
      if (response.error != null) {
        throw response.error!;
      }
      print("Menu items fetched: ${response.data}");
      return response.data;
    } catch (e) {
      print('Error fetching menu items: $e');
      rethrow;
    }
  }
}
