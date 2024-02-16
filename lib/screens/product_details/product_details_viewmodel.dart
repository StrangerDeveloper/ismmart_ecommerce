import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/api_base_helper.dart';
import 'package:ismmart_ecommerce/helpers/common_function.dart';
import 'package:ismmart_ecommerce/helpers/global_variables.dart';
import 'package:ismmart_ecommerce/helpers/urls.dart';
import 'package:ismmart_ecommerce/screens/product_details/model/product_model.dart';
import 'package:ismmart_ecommerce/screens/product_details/model/review_model.dart';

class ProductDetailsViewModel extends GetxController {
  // These keys are used for scrolling to specific container
  GlobalKey reviewsKey = GlobalKey();
  GlobalKey vendorKey = GlobalKey();
  GlobalKey similarProductKey = GlobalKey();
  ScrollController scrollController = ScrollController();

  //late TabController tabController;

  RxBool selectedTabIndex = true.obs;
  RxInt carouselIndex = 0.obs;

  PageController pageViewController = PageController(initialPage: 0);

  TextEditingController productQtyController = TextEditingController();

  RxString productID = ''.obs;

  RxString selectedOption = ''.obs;
  Map<String, String> selectedOptionList = <String, String>{}.obs;

  // RxList<Review> reviewsList = <Review>[].obs;

  Rx<Product> productModel = Product().obs;

  // Map<String, dynamic> optionsList = {
  //   'Colors': ['Green', 'Blue', 'Red'],
  //   'Size': ['S', 'M', 'L', 'XL'],
  //   'Model': ['2019', '2018', '2020', '2021'],
  //   'Colors1': ['Green', 'Blue', 'Red'],
  //   'Size2': ['S', 'M', 'L', 'XL'],
  //   'Model3': ['2029', '2038', '2010', '2221'],
  // };

  List<Review> reviewsList = [
    Review(
        rating: 3.0,
        description: 'this is description of review1',
        images: [
          ' https://firebasestorage.googleapis.com/v0/b/ismmart-vms.appspot.com/o/Product%2FoZtVHPX.jpeg-1706766530340?alt=media&token=e7808de5-9d2f-4c16-be53-a68f46bc0be4'
        ],
        user: User(
            email: 'gMirranig@gmailg.comg',
            name: 'NameABC1',
            image:
                'https://firebasestorage.googleapis.com/v0/b/ismmart-vms.appspot.com/o/Product%2Ffedex.png-1706741123313?alt=media&token=8379187c-162f-4c1e-9f34-7b06cbf4053c')),
    Review(
        rating: 4.5,
        description: 'this is description of review2',
        images: [
          ' https://firebasestorage.googleapis.com/v0/b/ismmart-vms.appspot.com/o/Product%2FoZtVHPX.jpeg-1706766530340?alt=media&token=e7808de5-9d2f-4c16-be53-a68f46bc0be4'
        ],
        user: User(
            email: 'example1@gmail.com',
            name: 'NameABC2',
            image:
                'https://firebasestorage.googleapis.com/v0/b/ismmart-vms.appspot.com/o/Product%2Ffedex.png-1706741123313?alt=media&token=8379187c-162f-4c1e-9f34-7b06cbf4053c'))
  ];
  //Product get productModel => _product.value;
  int qtyCount = 1;
  @override
  void onReady() {
    super.onReady();
    if (Get.arguments != null) {
      productID.value = Get.arguments['productId'];
    }
    getProductById();
    getProductReviews();
  }

  Future<void> getProductById() async {
    GlobalVariable.showLoader.value = true;

    print("PRoductIDDD : ${productID.value}");
    Map<String, String> params = {
      'id': productID.value,
      'fields[name]': '1',
      'fields[price]': '1',
      'fields[options]': '1',
      'fields[store]': '1',
      'fields[variants]': '1',
      'fields[media]': '1',
      'fields[description]': '1',
      'fields[totalReviews]': '1',
      'fields[rating]': '1',
      'fields[quantity]': '1',
      'fields[discount]': '1'
    };

    await ApiBaseHelper()
        .getMethodQueryParam(url: Urls.getProducts, params: params)
        .then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if (parsedJson['success'] == true) {
        var data = parsedJson['data'];

        ProductResponse productResponse = ProductResponse.fromJson(data);
        productModel.value = productResponse.products!.first;
      } else {
        CommonFunction.debugPrint(parsedJson['message']);
      }
    }).catchError((e) {
      CommonFunction.debugPrint(e);
    });
  }

  Future getProductReviews() async {
    Map<String, String> params = {
      'limit': '2',
      'product': productID.value,
    };
    await ApiBaseHelper()
        .getMethodQueryParam(url: Urls.getProductReviews, params: params)
        .then((parsedJson) {
      if (parsedJson['success'] == true) {
        CommonFunction.debugPrint(parsedJson['message']);

        var data = parsedJson['data'];
        ReviewResponse reviewResponse = ReviewResponse.fromJson(data);
        reviewsList.addAll(reviewResponse.review!);
      } else {
        CommonFunction.debugPrint(parsedJson['message']);
      }
    }).catchError((e) {
      CommonFunction.debugPrint(e);
    });
  }

  void scrollTo(GlobalKey key) {
    final RenderObject renderObject = key.currentContext!.findRenderObject()!;
    final position = renderObject.semanticBounds.bottom;
    print('Position: $position');
    scrollController.animateTo(
      position,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  void onQtyIncrement() {
    qtyCount++;
    productQtyController.text = "$qtyCount";
  }

  void onQtyDecrement() {
    if (qtyCount <= 1) return;
    qtyCount--;
    productQtyController.text = "$qtyCount";
  }

  int getCurrentMediaIndex() {
    if (productModel.value.media == null || productModel.value.media!.isEmpty) {
      return 0;
    }
    return (carouselIndex.value) + 1;
  }

  @override
  void onClose() {
    pageViewController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
