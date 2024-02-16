class ProductResponse {
  List<Product>? products;
  num? page;
  num? limit;
  num? pages;
  num? total;

  ProductResponse({
    this.products,
    this.page,
    this.limit,
    this.pages,
    this.total,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
        products: json["items"] == null
            ? []
            : List<Product>.from(
                json["items"]!.map((x) => Product.fromJson(x))),
        page: json["page"],
        limit: json["limit"],
        pages: json["pages"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "Product": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "page": page,
        "limit": limit,
        "pages": pages,
        "total": total,
      };
}

class Product {
  String? id;
  String? name;
  bool? physical;
  String? description;
  String? slug;
  String? status;
  List<dynamic>? channels;
  List<String>? tags;
  String? vendor;
  Store? store;
  List<Media>? media;
  List<Option>? options;
  Seo? seo;
  Type? type;
  List<Type>? categories;
  List<Collection>? collections;
  bool? active;
  bool? deleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  Discount? discount;
  num? totalSum;
  num? totalReviews;
  double? rating;
  String? inventory;
  num? quantity;
  bool? inStock;
  num? price;
  String? image;
  num? likes;
  bool? liked;
  List<Variant>? variants;

  Product({
    this.id,
    this.name,
    this.physical,
    this.description,
    this.slug,
    this.status,
    this.channels,
    this.tags,
    this.vendor,
    this.store,
    this.media,
    this.options,
    this.seo,
    this.type,
    this.categories,
    this.collections,
    this.active,
    this.deleted,
    this.createdAt,
    this.updatedAt,
    this.discount,
    this.totalSum,
    this.totalReviews,
    this.rating,
    this.inventory,
    this.quantity,
    this.inStock,
    this.price,
    this.image,
    this.likes,
    this.liked,
    this.variants,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        name: json["name"],
        physical: json["physical"],
        description: json["description"],
        slug: json["slug"],
        status: json["status"],
        channels: json["channels"] == null
            ? []
            : List<dynamic>.from(json["channels"]!.map((x) => x)),
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        vendor: json["vendor"],
        store: json["store"] == null ? null : Store.fromJson(json["store"]),
        media: json["media"] == null
            ? []
            : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
        options: json["options"] == null
            ? []
            : List<Option>.from(
                json["options"]!.map((x) => Option.fromJson(x))),
        seo: json["seo"] == null ? null : Seo.fromJson(json["seo"]),
        type: json["type"] == null ? null : Type.fromJson(json["type"]),
        categories: json["categories"] == null
            ? []
            : List<Type>.from(json["categories"]!.map((x) => Type.fromJson(x))),
        collections: json["collections"] == null
            ? []
            : List<Collection>.from(
                json["collections"]!.map((x) => Collection.fromJson(x))),
        active: json["active"],
        deleted: json["deleted"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        discount: json["discount"] == null
            ? null
            : Discount.fromJson(json["discount"]),
        totalSum: json["totalSum"],
        totalReviews: json["totalReviews"],
        rating: json["rating"]?.toDouble(),
        inventory: json["inventory"],
        quantity: json["quantity"],
        inStock: json["inStock"],
        price: json["price"],
        image: json["image"],
        likes: json["likes"],
        liked: json["liked"] ?? false,
        variants: json["variants"] == null
            ? []
            : List<Variant>.from(
                json["variants"]!.map((x) => Variant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "physical": physical,
        "description": description,
        "slug": slug,
        "status": status,
        "channels":
            channels == null ? [] : List<dynamic>.from(channels!.map((x) => x)),
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "vendor": vendor,
        "store": store?.toJson(),
        "media": media == null
            ? []
            : List<dynamic>.from(media!.map((x) => x.toJson())),
        "options": options == null
            ? []
            : List<dynamic>.from(options!.map((x) => x.toJson())),
        "seo": seo?.toJson(),
        "type": type?.toJson(),
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "collections": collections == null
            ? []
            : List<dynamic>.from(collections!.map((x) => x.toJson())),
        "active": active,
        "deleted": deleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "discount": discount?.toJson(),
        "totalSum": totalSum,
        "totalReviews": totalReviews,
        "rating": rating,
        "inventory": inventory,
        "quantity": quantity,
        "inStock": inStock,
        "price": price,
        "image": image,
        "likes": likes,
        "liked": liked,
        "variants": variants == null
            ? []
            : List<dynamic>.from(variants!.map((x) => x.toJson())),
      };
}

class Type {
  String? id;
  String? name;

  Type({
    this.id,
    this.name,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

class Collection {
  String? id;
  String? name;
  List<dynamic>? media;

  Collection({
    this.id,
    this.name,
    this.media,
  });

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        id: json["_id"],
        name: json["name"],
        media: json["media"] == null
            ? []
            : List<dynamic>.from(json["media"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x)),
      };
}

class Discount {
  String? id;
  String? name;
  num? percentage;

  Discount({
    this.id,
    this.name,
    this.percentage,
  });

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
        id: json["_id"],
        name: json["name"],
        percentage: json["percentage"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "percentage": percentage,
      };
}

class Media {
  String? url;
  bool? thumbnail;
  String? type;
  String? id;

  Media({
    this.url,
    this.thumbnail,
    this.type,
    this.id,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        url: json["url"],
        thumbnail: json["thumbnail"],
        type: json["type"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "thumbnail": thumbnail,
        "type": type,
        "_id": id,
      };
}

class Option {
  String? name;
  List<String>? values;
  String? id;

  Option({
    this.name,
    this.values,
    this.id,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        name: json["name"],
        // values: json["values"] == null
        //     ? []
        //     : List<VariantOption>.from(json["values"]!.map((x) => VariantOption(selected: false, name))),
        values: json["values"] == null
            ? []
            : List<String>.from(json["values"]!.map((x) => x)),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "values":
            values == null ? [] : List<dynamic>.from(values!.map((x) => x)),
        "_id": id,
      };
}

class Seo {
  List<dynamic>? keywords;

  Seo({
    this.keywords,
  });

  factory Seo.fromJson(Map<String, dynamic> json) => Seo(
        keywords: json["keywords"] == null
            ? []
            : List<dynamic>.from(json["keywords"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "keywords":
            keywords == null ? [] : List<dynamic>.from(keywords!.map((x) => x)),
      };
}

class Store {
  String? id;
  String? name;
  String? logo;
  String? slug;
  List<Product>? products;
  num? totalReviews;
  double? rating;

  Store({
    this.id,
    this.name,
    this.logo,
    this.slug,
    this.products,
    this.totalReviews,
    this.rating,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["_id"],
        name: json["name"],
        logo: json["logo"],
        slug: json["slug"],
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
        totalReviews: json["totalReviews"],
        rating: json["rating"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "logo": logo,
        "slug": slug,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "totalReviews": totalReviews,
        "rating": rating,
      };
}

class Variant {
  String? id;
  String? name;
  String? slug;
  num? weight;
  Dimensions? dimensions;
  List<String>? options;
  String? vendor;
  String? store;
  String? product;
  bool? deleted;
  List<dynamic>? media;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? inventory;
  num? quantity;
  bool? inStock;
  num? price;
  Discount? discount;

  Variant({
    this.id,
    this.name,
    this.slug,
    this.weight,
    this.dimensions,
    this.options,
    this.vendor,
    this.store,
    this.product,
    this.deleted,
    this.media,
    this.createdAt,
    this.updatedAt,
    this.inventory,
    this.quantity,
    this.inStock,
    this.price,
    this.discount,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        id: json["_id"],
        name: json["name"],
        slug: json["slug"],
        weight: json["weight"],
        dimensions: json["dimensions"] == null
            ? null
            : Dimensions.fromJson(json["dimensions"]),
        options: json["options"] == null
            ? []
            : List<String>.from(json["options"]!.map((x) => x)),
        vendor: json["vendor"],
        store: json["store"],
        product: json["product"],
        deleted: json["deleted"],
        media: json["media"] == null
            ? []
            : List<dynamic>.from(json["media"]!.map((x) => x)),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        inventory: json["inventory"],
        quantity: json["quantity"],
        inStock: json["inStock"],
        price: json["price"],
        discount: json["discount"] == null
            ? null
            : Discount.fromJson(json["discount"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "slug": slug,
        "weight": weight,
        "dimensions": dimensions?.toJson(),
        "options":
            options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
        "vendor": vendor,
        "store": store,
        "product": product,
        "deleted": deleted,
        "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "inventory": inventory,
        "quantity": quantity,
        "inStock": inStock,
        "price": price,
        "discount": discount?.toJson(),
      };
}

class Dimensions {
  num? width;
  num? length;
  num? height;

  Dimensions({
    this.width,
    this.length,
    this.height,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        width: json["width"],
        length: json["length"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "width": width,
        "length": length,
        "height": height,
      };
}

class VariantOption {
  String? name;
  bool? selected;

  VariantOption({this.name, this.selected});
}
