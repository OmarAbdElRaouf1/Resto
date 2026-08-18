import 'package:resto/features/cart/domain/entities/cart_entity.dart';

abstract class CartRepo {
  Future<CartEntity> getMyCart();

  Future<CartEntity> addItemToCart({
    required String productId,
    required int quantity,
  });
}
