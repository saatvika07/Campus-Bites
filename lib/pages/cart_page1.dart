import 'package:flutter/material.dart';
import 'package:login_signup/pages/cart_manager.dart';
import 'package:login_signup/pages/payment.dart';
import 'package:login_signup/widgets/custom_scaffold.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key, required List<Map<String, dynamic>> cartItems});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double calculateSubtotal(List<Map<String, dynamic>> items) {
    double subtotal = 0;
    for (var item in items) {
      double price = item['price'] is String ? double.parse(item['price']) : item['price'];
      subtotal += price * item['quantity'];
    }
    return subtotal;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Map<String, dynamic>>> groupedItems = CartManager().groupItemsByRestaurant();
    double calculateTotal() {
      double total = 0;
      groupedItems.forEach((_, items) {
        total += calculateSubtotal(items);
      });
      return total;
    }

    return CustomScaffold(
      title: "Cart",
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange.shade700,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                // Navigate to Home page
              },
            ),
            ListTile(
              title: Text('Cart'),
              onTap: () {
                // Navigate to Cart page
              },
            ),
          ],
        ),
      ),
      child: groupedItems.isEmpty
          ? const Center(
              child: Text(
                "Your cart is empty.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: groupedItems.entries.map((entry) {
                        String restaurantName = entry.key;
                        List<Map<String, dynamic>> items = entry.value;
                        double subtotal = calculateSubtotal(items);

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                restaurantName,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange.shade800,
                                ),
                              ),
                            ),
                            ...items.map((item) {
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      item['Image'],
                                      fit: BoxFit.cover,
                                      width: 60,
                                      height: 60,
                                    ),
                                  ),
                                  title: Text(
                                    item['Name'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '₹${item['price']} x ${item['quantity']}',
                                            style: const TextStyle(
                                                fontSize: 14, color: Colors.grey),
                                          ),
                                          Text(
                                            'Total: ₹${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.remove,
                                                color: Colors.red),
                                            onPressed: () {
                                              setState(() {
                                                if (item['quantity'] > 1) {
                                                  item['quantity']--;
                                                } else {
                                                  CartManager().removeItem(
                                                      item['Name'],
                                                      item['restaurantName']);
                                                }
                                              });
                                            },
                                          ),
                                          Text(
                                            '${item['quantity']}',
                                            style: const TextStyle(fontSize: 16),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.add,
                                                color: Colors.green),
                                            onPressed: () {
                                              setState(() {
                                                item['quantity']++;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon:
                                        const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        CartManager().removeItem(item['Name'],
                                            item['restaurantName']);
                                      });
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              '${item['Name']} removed from cart'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            }).toList(),
                            Card(
                              elevation: 6,
                              color: Colors.orange.shade50,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  'Subtotal for 🥳$restaurantName: ₹${subtotal.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange.shade800,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Text(
                          'Total: ₹${calculateTotal().toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade800,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(
          groupedItems: groupedItems,
        ),
      ),
    );
  },
  child: const Text('😋 Place Order'),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.green,
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
  ),
),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
