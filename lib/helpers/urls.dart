class Urls {
  static String baseUrl =
      "https://ismmart-ecommerce-backend-e233368b3b0d.herokuapp.com/api";
  static String getLocation = "/vendor/location?limit=5&page=";

  static String login = "/customer/auth/login";
  static String register = "/customer/auth/register";
  static String forgetPassword = "/auth/forgot";
  static String resetPassword = "/auth/reset";
  static String getOrders = "/vendor/order";
  static String getProfile = "/auth/profile";
  static String editProfile = "/customer/auth/update";
  static String getVendorStoreDetails = '/public/store?';
  //HomeViewModel
  static String getCollection = "/public/collection";
  static String getNews = "/public/news";
  static String getFlashDiscountTimer = "/public/discount";
  //Products
  static String getProducts = "/public/product";

  //reviews
  static String getProductReviews = "public/review";
}
