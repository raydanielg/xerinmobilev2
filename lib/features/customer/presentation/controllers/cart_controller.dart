import 'package:flutter/foundation.dart';

class CartItem {
  final String name;
  final String price;
  final String image;
  final String category;
  int quantity;

  CartItem({
    required this.name,
    required this.price,
    required this.image,
    required this.category,
    this.quantity = 1,
  });
}

class CartController extends ChangeNotifier {
  static final CartController _instance = CartController._internal();
  factory CartController() => _instance;
  CartController._internal();

  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get count => _items.fold(0, (sum, item) => sum + item.quantity);

  double get total {
    return _items.fold(0, (sum, item) {
      final priceValue = double.tryParse(
            item.price.replaceAll('\$', '').replaceAll(',', ''),
          ) ??
          0;
      return sum + (priceValue * item.quantity);
    });
  }

  void addToCart({
    required String name,
    required String price,
    required String image,
    required String category,
  }) {
    final existing = _items.indexWhere((item) => item.name == name);
    if (existing >= 0) {
      _items[existing].quantity += 1;
    } else {
      _items.add(CartItem(
        name: name,
        price: price,
        image: image,
        category: category,
      ));
    }
    notifyListeners();
  }

  void removeFromCart(String name) {
    _items.removeWhere((item) => item.name == name);
    notifyListeners();
  }

  void updateQuantity(String name, int quantity) {
    final index = _items.indexWhere((item) => item.name == name);
    if (index < 0) return;
    if (quantity <= 0) {
      _items.removeAt(index);
    } else {
      _items[index].quantity = quantity;
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
