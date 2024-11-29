import 'package:flutter/material.dart';
import 'cart_page.dart'; // Import the CartPage
import 'package:login_signup/widgets/custom_scaffold.dart';
import 'package:login_signup/widgets/search_widget.dart';

class PaniPuriPage extends StatefulWidget {
  const PaniPuriPage({super.key});

  @override
  _PaniPuriPageState createState() => _PaniPuriPageState();
}

class _PaniPuriPageState extends State<PaniPuriPage> {
  final List<Map<String, dynamic>> foodItems = [
    {'name': 'Veg Fried Rice', 'image': 'assets/images/BG.png', 'quantity': 0, 'price': 150},
    {'name': 'Egg Fried Rice', 'image': 'assets/images/efr.jpg', 'quantity': 0, 'price': 180},
    {'name': 'Chicken Fried Rice', 'image': 'assets/images/cfr.jpg', 'quantity': 0, 'price': 220},
    {'name': 'Veg Noodles', 'image': 'assets/images/vn.png', 'quantity': 0, 'price': 130},
    {'name': 'Egg Noodles', 'image': 'assets/images/en.jpg', 'quantity': 0, 'price': 160},
    {'name': 'Chicken Noodles', 'image': 'assets/images/cn.jpg', 'quantity': 0, 'price': 200},
    {'name': 'Chicken 65', 'image': 'assets/images/ch65.jpg', 'quantity': 0, 'price': 250},
    {'name': 'Veg Manchuria', 'image': 'assets/images/vm.jpg', 'quantity': 0, 'price': 170},
    {'name': 'Chicken Manchuria', 'image': 'assets/images/cm.jpg', 'quantity': 0, 'price': 190},
  ];

  List<Map<String, dynamic>> cartItems = [];

  void addToCart(int index) {
    setState(() {
      var itemInCart = cartItems.firstWhere(
        (item) => item['name'] == foodItems[index]['name'],
        orElse: () => {},
      );

      if (itemInCart.isEmpty) {
        cartItems.add({
          'name': foodItems[index]['name'],
          'image': foodItems[index]['image'],
          'quantity': 1,
          'price': foodItems[index]['price'],
        });
      } else {
        itemInCart['quantity']++;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${foodItems[index]['name']} added to cart!'),
        backgroundColor: Colors.green.shade600,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: ListView(
        children: [
          const SearchWidget(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.8,
              ),
              itemCount: foodItems.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 8,
                  shadowColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          foodItems[index]['image'],
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Text(
                                foodItems[index]['name'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '₹${foodItems[index]['price']}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange.shade700,
                                ),
                                onPressed: () => addToCart(index),
                                child: const Text(
                                  'Add to Cart',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PaniPuriPage(),
  ));
}
