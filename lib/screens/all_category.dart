import 'package:gomez_store_app/screens/products_by_category.dart';
import 'package:flutter/material.dart';

import '../services/api_service.dart';
ApiService apiService = ApiService();
class AllCategoryScreen extends StatelessWidget {
  const AllCategoryScreen({Key? key}) : super(key: key);

  String? get categoryName => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder(
        future: getAllCategories(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final categories = snapshot.data;
          return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductsByCategoryScreen(
                          categoryName: categories[index].toString(),
                        ),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(40),
                      child: Center(
                        child: Text(
                          categoryName ?? categories[index].toString(),
                          style: const TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }

  getAllCategories() {
    return apiService.getAllCategories();
  }
}
