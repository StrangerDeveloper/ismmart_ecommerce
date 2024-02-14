import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../product_details/product_model.dart';

class WishlistViewModel extends GetxController {
  static final localStorage = GetStorage();
  RxList<Product> wishlist = <Product>[].obs;
  RxInt totalItems = 0.obs;

  // Retrieve wishlist from local storage during initialization
  @override
  void onInit() {
    super.onInit();
    List<Product> savedWishlist =
        localStorage.read<List<Product>>('wishlist') ?? [];
    wishlist.assignAll(savedWishlist);
  }

  void addToWishlist(Product product) {
    print('object: ${product.name}');
    wishlist.add(product);
    wishlist.refresh();
    totalItems.value = wishlist.length;
    localStorage.write('wishlist', wishlist.toList());
    print('wishlist nameeeeee: ${wishlist[0].name}');
  }

  void removeFromWishlist(Product product) {
    wishlist.remove(product);
    wishlist.refresh();
    totalItems.value = wishlist.length;
    localStorage.write('wishlist', wishlist.toList());
  }
}
