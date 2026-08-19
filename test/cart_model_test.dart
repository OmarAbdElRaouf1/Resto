import 'package:flutter_test/flutter_test.dart';
import 'package:resto/features/cart/data/models/cart_item_model.dart';
import 'package:resto/features/cart/data/models/cart_model.dart';

void main() {
  group('CartModel & CartItemModel deserialization tests', () {
    test('parses populated product object correctly', () {
      final json = {
        '_id': 'cart123',
        'items': [
          {
            '_id': 'item1',
            'product': {
              '_id': 'prod1',
              'name': 'Cheeseburger',
              'description': 'Delicious burger with cheddar',
              'price': 120,
              'image': 'https://example.com/burger.png',
            },
            'quantity': 2,
            'price': 120,
          }
        ],
      };

      final cart = CartModel.fromJson(json);
      expect(cart.id, 'cart123');
      expect(cart.items?.length, 1);
      final item = cart.items!.first;
      expect(item.id, 'item1');
      expect(item.productId, 'prod1');
      expect(item.product?.name, 'Cheeseburger');
      expect(item.quantity, 2);
      expect(item.price, 120);
    });

    test('parses string product ID correctly', () {
      final json = {
        '_id': 'item2',
        'product': 'prod2',
        'name': 'Fries',
        'quantity': '3',
        'price': '45',
      };

      final item = CartItemModel.fromJson(json);
      expect(item.id, 'item2');
      expect(item.productId, 'prod2');
      expect(item.product?.name, 'Fries');
      expect(item.quantity, 3);
      expect(item.price, 45);
    });

    test('parses wrapped data envelope correctly', () {
      final json = {
        'status': 'success',
        'data': {
          '_id': 'cart999',
          'items': [
            {
              'productId': 'prod3',
              'quantity': 1,
              'price': 80,
            }
          ],
        },
      };

      final cart = CartModel.fromJson(json);
      expect(cart.id, 'cart999');
      expect(cart.items?.length, 1);
      expect(cart.items?.first.productId, 'prod3');
      expect(cart.items?.first.price, 80);
    });
  });
}
