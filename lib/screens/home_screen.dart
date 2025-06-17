// ignore_for_file: use_key_in_widget_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/controllers/product_controller.dart';
import 'package:user_app/screens/login_screen.dart';
import '../models/product_model.dart';



class HomeScreen extends StatelessWidget {

  final ProductController controller = ProductController();
  void logout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear(); 

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoginScreen()),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => logout(context),
          ),
        ],
      ),
      body: FutureBuilder<ProductResponse>(
        future: controller.fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          else if (snapshot.hasError){
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          else {
            final products = snapshot.data!.products;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final p = products[index];
                return ListTile(
                  leading: Image.network(p.thumbnail, width: 50),
                  title: Text(p.title),
                  subtitle: Text('\$${p.price}'),
                );
              },
            );
          }
        },
      ),
      
    );
  }
}
