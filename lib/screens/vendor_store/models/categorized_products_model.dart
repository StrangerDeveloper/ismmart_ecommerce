class CategorizedProductsModel {

  String? categoryName;
  List<Product>? productList;

  CategorizedProductsModel({
    this.categoryName,
    this.productList,
  });

}

class Product {

  String? id;
  String? name;
  String? imageURL;
  int? discountedPrice;
  int? actualPrice;
  double? reviewStar;
  int? reviewsNumber;

  Product({
    this.id,
    this.name,
    this.imageURL,
    this.actualPrice,
    this.discountedPrice,
    this.reviewsNumber,
    this.reviewStar
  });
}