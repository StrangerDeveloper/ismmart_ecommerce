class Urls {
  static String baseUrl =
      "https://ismmart-ecommerce-backend-e233368b3b0d.herokuapp.com/api";
  static String getLocation = "/vendor/location?limit=5&page=";

  static String login = "/customer/auth/login";
  static String register = "/customer/auth/register";
  static String forgetPassword = "/auth/forgot";
  static String resetPassword = "/auth/reset";
  static String getOrders = "/vendor/order";
  static String getSliderProducts =
      "/public/product?limit=3&popular=true&store=65b0dc2d9d21c52c7d22f1bf&fields[name]=1&fields[image]=1&fields[id]=1";
  static String getVendorProductsCategories =
      '/public/collection?limit=0&fields[name]=1&store=65b0dc2d9d21c52c7d22f1bf&fields[media]=1';

  //HomeViewModel
  static String homeCollections = "/public/collection";
  static String getNews =
      "/public/news?limit=0&fields[name]=1&fields[description]=1";
  static String getDiscount =
      "/public/discount?limit=6&fields[name]=1&fields[start]=1&fields[end]=1";
  static String getDiscountedProducts =
      "/public/product?limit=6&fields[image]=1&fields[quantity]=1&fields[inStock]=1&fields[store][name]=1&fields[discount][percentage]=1&fields[totalReviews]=1&fields[rating]=1&fields[price]=1&discount=";
  // static String getSimpleProducts = "/public/product?limit=6&fields[image]=1&fields[name]=1&fields[quantity]=1&fields[inStock]=1&fields[store][name]=1&fields[discount][percentage]=1&fields[totalReviews]=1&fields[rating]=1&fields[price]=1&limit=10&collection=";
  static String getSimpleProducts =
      "/public/product?fields[image]=1&fields[quantity]=1&fields[name]=1&fields[inStock]=1&fields[store][name]=1&fields[discount][percentage]=1&fields[totalReviews]=1&fields[rating]=1&fields[price]=1&limit=2";
}
