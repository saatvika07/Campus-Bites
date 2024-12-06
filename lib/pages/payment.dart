import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  final Map<String, List<Map<String, dynamic>>> groupedItems;

  const PaymentPage({Key? key, required this.groupedItems}) : super(key: key);

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: Colors.orange,
      ),
      body: groupedItems.isEmpty
          ? const Center(
              child: Text(
                "No items to display.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : ListView(
              children: groupedItems.entries.map((entry) {
                String restaurantName = entry.key;
                List<Map<String, dynamic>> items = entry.value;
                double subtotal = calculateSubtotal(items);

                return Card(
                  margin: const EdgeInsets.all(12),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurantName,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Total Payable: ₹${subtotal.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 16, color: Colors.green),
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: Column(
                            children: [
                              const Text(
                                "Scan the QR code to pay:",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 8),
                              Image.asset(
                                'assets/images/qr_code.png', // Single QR code image
                                width: 150,
                                height: 150,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }
}
