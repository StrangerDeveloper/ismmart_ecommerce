class Urls {
  static String baseUrl =
      "https://ismmart-ecommerce-backend-e233368b3b0d.herokuapp.com/api";
  static String getLocation = "/vendor/location?limit=5&page=";

  static String login = "/customer/auth/login";
  static String socialLogin = "/customer/auth/login/social";
  static String register = "/customer/auth/register";
  static String forgetPassword = "/auth/forgot";
  static String resetPassword = "/auth/reset";
  static String getOrders = "/vendor/order";
  static String getProfile = "/auth/profile";
  static String editProfile = "/customer/auth/update";
  static String getSliderProducts =
      "/public/product?limit=3&popular=true&store=65b0dc2d9d21c52c7d22f1bf&fields[name]=1&fields[image]=1&fields[id]=1";
  static String getVendorProductsCategories =
      '/public/collection?limit=0&fields[name]=1&store=65b0dc2d9d21c52c7d22f1bf&fields[media]=1';

  //HomeViewModel
  static String homeCollections = "/public/collection";
  static String getNews = "/public/news";
  static String getFlashDiscountTimer = "/public/discount";
  //Products
  static String getProducts = "/public/product";

  //reviews
  static String getProductReviews = "public/review";
}
