class CartManager {
  static final CartManager _instance = CartManager._internal();

  // Singleton pattern
  factory CartManager() => _instance;

  CartManager._internal();

  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => List.unmodifiable(_cartItems);

  void addItem(Map<String, dynamic> item, String restaurantName) {
    var existingItem = _cartItems.firstWhere(
      (cartItem) => cartItem['Name'] == item['Name'] && cartItem['restaurantName'] == restaurantName,
      orElse: () => {},
    );

    if (existingItem.isEmpty) {
      _cartItems.add({
        'Name': item['Name'],
        'Image': item['Image'],
        'price': item['price'],
        'quantity': 1,
        'restaurantName': restaurantName,
      });
    } else {
      existingItem['quantity']++;
    }
  }

  void removeItem(String name, String restaurantName) {
    _cartItems.removeWhere((item) => item['Name'] == name && item['restaurantName'] == restaurantName);
  }

  void clearCart() {
    _cartItems.clear();
  }

  Map<String, List<Map<String, dynamic>>> groupItemsByRestaurant() {
    Map<String, List<Map<String, dynamic>>> groupedItems = {};
    for (var item in _cartItems) {
      if (groupedItems.containsKey(item['restaurantName'])) {
        groupedItems[item['restaurantName']]!.add(item);
      } else {
        groupedItems[item['restaurantName']] = [item];
      }
    }
    return groupedItems;
  }
}
