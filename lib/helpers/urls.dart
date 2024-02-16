class Urls {
  static String baseUrl =
      "https://ismmart-ecommerce-backend-e233368b3b0d.herokuapp.com/api";
  static String getLocation = "/vendor/location?limit=5&page=";

  //Auth
  static String login = "/customer/auth/login";
  static String socialLogin = "/customer/auth/login/social";
  static String register = "/customer/auth/register";
  static String forgetPassword = "/auth/forgot";
  static String resetPassword = "/auth/reset";
  static String getOrders = "/customer/order";

  //profile
  static String getProfile = "/auth/profile";
  static String editProfile = "/customer/auth/update";

  static String getOrders = "/vendor/order";
  static String getVendorStoreDetails = '/public/store?';

  //HomeViewModel
  static String getCollection = "/public/collection";
  static String getNews = "/public/news";
  static String getFlashDiscountTimer = "/public/discount";
  static String getFilterSetting = "/public/product/filters";

  //Products
  static String getProducts = "/public/product";

  //reviews
  static String getProductReviews = "/public/review";
  static String updateFcmToken = "/device/update/:";

  static String getFAQs = "/public/faq";

  //checktout
  static String getShippingAdress = "/customer/location?limit=0";
  static String getCountries = "/places/countries?limit=0";
  static String getCities = "/places/cities?limit=0&country=";
  static String addLocation = "/customer/location/add";
  static String updateLocation = "/customer/location/update/:id";
}
