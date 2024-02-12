class Urls {
  static String baseUrl =
      "https://ismmart-ecommerce-backend-e233368b3b0d.herokuapp.com/api";
  static String getLocation = "/vendor/location?limit=5&page=";
  static String getOrders = "/vendor/order";
  static String getSliderProducts = "/public/product?limit=3&popular=true&store=65b0dc2d9d21c52c7d22f1bf&fields[name]=1&fields[image]=1&fields[id]=1";
  static String getVendorProductsCategories = '/public/collection?limit=0&fields[name]=1&store=65b0dc2d9d21c52c7d22f1bf&fields[media]=1';

  //HomeViewModel
  static String homeCollections = "/public/collection?limit=0&level=1&fields[name]=1&fields[media]=1&fields[children]=1";
}
