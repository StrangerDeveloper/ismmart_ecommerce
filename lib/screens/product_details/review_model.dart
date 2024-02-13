import 'product_model.dart';

class ReviewResponse {
    List<Review>? review;
    num? page;
    num? limit;
    num? pages;
    num? total;

    ReviewResponse({
        this.review,
        this.page,
        this.limit,
        this.pages,
        this.total,
    });

    factory ReviewResponse.fromJson(Map<String, dynamic> json) => ReviewResponse(
        review: json["Review"] == null ? [] : List<Review>.from(json["Review"]!.map((x) => Review.fromJson(x))),
        page: json["page"],
        limit: json["limit"],
        pages: json["pages"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "Review": review == null ? [] : List<dynamic>.from(review!.map((x) => x.toJson())),
        "page": page,
        "limit": limit,
        "pages": pages,
        "total": total,
    };
}

class Review {
    String? id;
    num? rating;
    String? description;
    List<String>? images;
    User? user;
    Product? product;
    bool? active;
    bool? deleted;
    DateTime? createdAt;
    DateTime? updatedAt;

    Review({
        this.id,
        this.rating,
        this.description,
        this.images,
        this.user,
        this.product,
        this.active,
        this.deleted,
        this.createdAt,
        this.updatedAt,
    });

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["_id"],
        rating: json["rating"],
        description: json["description"],
        images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        active: json["active"],
        deleted: json["deleted"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "rating": rating,
        "description": description,
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "user": user?.toJson(),
        "product": product?.toJson(),
        "active": active,
        "deleted": deleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
class User {
    String? id;
    String? email;
    String? name;
    String? image;

    User({
        this.id,
        this.email,
        this.name,
        this.image,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        email: json["email"],
        name: json["name"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "name": name,
        "image": image,
    };
}
