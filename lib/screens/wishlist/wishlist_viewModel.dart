import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../product_details/product_model.dart';

class WishlistViewModel extends GetxController {
  static final localStorage = GetStorage();
  RxList<Product> wishlist = <Product>[].obs;
  RxInt totalItems = 0.obs;
  RxInt wishlistCounter = 0.obs;

  // Retrieve wishlist from local storage during initialization
  @override
  void onReady() {
    super.onReady();

    List<dynamic> savedWishlist = localStorage.read('wishlist') ?? [];

    wishlist.addAll(savedWishlist as List<Product>);
  }

  void addToWishlist(Product product) {
    wishlist.add(product);
    wishlist.refresh();
    totalItems.value = wishlist.length;
    localStorage.write('wishlist', wishlist.toList());
    wishlistCounter.value++;
  }

  void removeFromWishlist(Product product) {
    wishlist.remove(product);
    wishlist.refresh();
    totalItems.value = wishlist.length;
    localStorage.write('wishlist', wishlist.toList());
    wishlistCounter.value--;
  }
}
