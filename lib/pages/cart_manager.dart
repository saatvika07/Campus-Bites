class CartManager {
  static final CartManager _instance = CartManager._internal();

  // Singleton pattern
  factory CartManager() => _instance;

  CartManager._internal();

  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => List.unmodifiable(_cartItems);

  void addItem(Map<String, dynamic> item) {
    var existingItem = _cartItems.firstWhere(
      (cartItem) => cartItem['Name'] == item['Name'],
      orElse: () => {},
    );

    if (existingItem.isEmpty) {
      _cartItems.add({
        'Name': item['Name'],
        'Image': item['Image'],
        'price': item['price'],
        'quantity': 1,
      });
    } else {
      existingItem['quantity']++;
    }
  }

  void removeItem(String name) {
    _cartItems.removeWhere((item) => item['Name'] == name);
  }

  void clearCart() {
    _cartItems.clear();
  }
}
