import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../product_details/product_model.dart';

class WishlistViewModel extends GetxController {
  List<String> categoriesList = <String>[
    'https://images.unsplash.com/photo-1575936123452-b67c3203c357?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1528162771413-a34de3292ab1?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1508833876629-23d0873cfa06?q=80&w=1631&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1575936123452-b67c3203c357?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1528162771413-a34de3292ab1?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1508833876629-23d0873cfa06?q=80&w=1631&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ].obs;

  static final localStorage = GetStorage();
  RxList<Product> wishlist = <Product>[].obs;

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
    localStorage.write('wishlist', wishlist.toList());
    print('wishlist nameeeeee: ${wishlist[0].name}');
  }

  void removeFromWishlist(Product product) {
    wishlist.remove(product);
    localStorage.write('wishlist', wishlist.toList());
  }
}
