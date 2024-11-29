import 'package:flutter/material.dart';
import 'cart_page.dart'; // Import the CartPage

class FastFoodPage extends StatefulWidget {
  @override
  _FastFoodPageState createState() => _FastFoodPageState();
}

class _FastFoodPageState extends State<FastFoodPage> {
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
    // Find the item in the cart
    var itemInCart = cartItems.firstWhere(
      (item) => item['name'] == foodItems[index]['name'],
      orElse: () => {} // Return an empty map if not found
    );

    // If the item is not in the cart, add it
    if (itemInCart.isEmpty) {
      cartItems.add({
        'name': foodItems[index]['name'],
        'image': foodItems[index]['image'],
        'quantity': 1,
        'price': foodItems[index]['price'],
      });
    } else {
      // If item is already in the cart, increment its quantity
      itemInCart['quantity']++;
    }
  });

  // Show a SnackBar with a success message
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        '${foodItems[index]['name']} added to cart!',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.green.shade600,
      duration: Duration(seconds: 2), // Duration for the SnackBar
    ),
  );
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fast Food"),
        backgroundColor: const Color.fromARGB(255, 244, 243, 243),
        centerTitle: true,
        elevation: 8,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to cart page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(cartItems: cartItems),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade100, Colors.yellow.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Two items per row
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
                    // Food image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: SizedBox.expand(
                        child: Image.asset(
                          foodItems[index]['image'],
                          fit: BoxFit.cover, // Ensures the image covers the space
                        ),
                      ),
                    ),
                    // Text overlay on the image
                    Positioned(
                      bottom: 10,
                      left: 10,
                      right: 10,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5), // Semi-transparent background
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(
                              foodItems[index]['name'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '₹${foodItems[index]['price']}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange.shade700,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () => addToCart(index),
                              child: Text(
                                'Add to Cart',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
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
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // This hides the debug banner
    home: FastFoodPage(),
  ));
}
