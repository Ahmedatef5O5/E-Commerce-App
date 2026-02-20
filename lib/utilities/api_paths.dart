class ApiPaths {
  static String users(String userId) => 'users/$userId'; // users/$userId
  static String products() => 'products/'; // products/
  static String product(String productId) =>
      'products/$productId'; // products/$productId';
  static String announcements() => 'announcements/'; // announcements/
  static String categories() => 'categories/'; // announcements/

  static String cartItem(String userId, String cartItemId) =>
      'users/$userId/cart/$cartItemId'; // users/$userId/cart/$cartItemId';
}
