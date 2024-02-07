class OrderItem {
  String? sId;
  Customer? customer;
  ContactInfo? contactInfo;
  Address? address;
  List<Lineitem>? lineitems;
  String? status;
  OrderDetails? orderDetails;
  String? paymentType;
  ShippingMethod? shippingMethod;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  String? orderId;
  int? iV;
  OrderTotals? totals;
  String? paymentStatus;
  String? fulfilmentStatus;
  String? deliveryStatus;
  String? returnStatus;

  OrderItem(
      {this.sId,
      this.customer,
      this.contactInfo,
      this.address,
      this.lineitems,
      this.status,
      this.orderDetails,
      this.paymentType,
      this.shippingMethod,
      this.deleted,
      this.createdAt,
      this.updatedAt,
      this.orderId,
      this.iV,
      this.totals,
      this.paymentStatus,
      this.fulfilmentStatus,
      this.deliveryStatus,
      this.returnStatus});

  OrderItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    contactInfo = json['contactInfo'] != null
        ? ContactInfo.fromJson(json['contactInfo'])
        : null;
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    if (json['lineitems'] != null) {
      lineitems = <Lineitem>[];
      json['lineitems'].forEach((v) {
        lineitems!.add(Lineitem.fromJson(v));
      });
    }
    status = json['status'];
    orderDetails = json['orderDetails'] != null
        ? OrderDetails.fromJson(json['orderDetails'])
        : null;
    paymentType = json['paymentType'];
    shippingMethod = json['shippingMethod'] != null
        ? ShippingMethod.fromJson(json['shippingMethod'])
        : null;
    deleted = json['deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    orderId = json['orderId'];
    iV = json['__v'];
    totals =
        json['totals'] != null ? OrderTotals.fromJson(json['totals']) : null;
    paymentStatus = json['paymentStatus'];
    fulfilmentStatus = json['fulfilmentStatus'];
    deliveryStatus = json['deliveryStatus'];
    returnStatus = json['returnStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (contactInfo != null) {
      data['contactInfo'] = contactInfo!.toJson();
    }
    if (address != null) {
      data['address'] = address!.toJson();
    }
    if (lineitems != null) {
      data['lineitems'] = lineitems!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    if (orderDetails != null) {
      data['orderDetails'] = orderDetails!.toJson();
    }
    data['paymentType'] = paymentType;
    if (shippingMethod != null) {
      data['shippingMethod'] = shippingMethod!.toJson();
    }
    data['deleted'] = deleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['orderId'] = orderId;
    data['__v'] = iV;
    if (totals != null) {
      data['totals'] = totals!.toJson();
    }
    data['paymentStatus'] = paymentStatus;
    data['fulfilmentStatus'] = fulfilmentStatus;
    data['deliveryStatus'] = deliveryStatus;
    data['returnStatus'] = returnStatus;
    return data;
  }
}

class Customer {
  String? sId;
  String? email;
  String? name;
  String? phone;
  String? gender;
  String? cnic;

  Customer(
      {this.sId, this.email, this.name, this.phone, this.gender, this.cnic});

  Customer.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    gender = json['gender'];
    cnic = json['cnic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['email'] = email;
    data['name'] = name;
    data['phone'] = phone;
    data['gender'] = gender;
    data['cnic'] = cnic;
    return data;
  }
}

class ContactInfo {
  String? email;
  String? phone;

  ContactInfo({this.email, this.phone});

  ContactInfo.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }
}

class Address {
  Shipping? shipping;
  Shipping? billing;

  Address({this.shipping, this.billing});

  Address.fromJson(Map<String, dynamic> json) {
    shipping =
        json['shipping'] != null ? Shipping.fromJson(json['shipping']) : null;
    billing =
        json['billing'] != null ? Shipping.fromJson(json['billing']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (shipping != null) {
      data['shipping'] = shipping!.toJson();
    }
    if (billing != null) {
      data['billing'] = billing!.toJson();
    }
    return data;
  }
}

class Shipping {
  String? city;
  String? country;
  String? address;
  String? phone;

  Shipping({this.city, this.country, this.address, this.phone});

  Shipping.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    country = json['country'];
    address = json['address'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    data['country'] = country;
    data['address'] = address;
    data['phone'] = phone;
    return data;
  }
}

class Lineitem {
  String? sId;
  String? product;
  String? vendor;
  String? name;
  String? media;
  int? qty;
  int? amount;
  Totals? totals;
  String? paymentStatus;
  String? fulfilmentStatus;
  String? deliveryStatus;
  String? returnStatus;
  int? discountPercentage;
  int? couponPercentage;
  String? variantName;
  int? customShipping;
  String? type;
  String? category;
  String? sku;
  String? barcode;
  double? weight;
  Dimensions? dimensions;
  Customer? assignedRider;
  List<Timeline>? timeline;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isSelected = false;

  Lineitem(
      {this.sId,
      this.product,
      this.vendor,
      this.name,
      this.media,
      this.qty,
      this.amount,
      this.totals,
      this.paymentStatus,
      this.fulfilmentStatus,
      this.deliveryStatus,
      this.returnStatus,
      this.discountPercentage,
      this.couponPercentage,
      this.variantName,
      this.customShipping,
      this.type,
      this.category,
      this.sku,
      this.barcode,
      this.weight,
      this.dimensions,
      this.assignedRider,
      this.timeline,
      this.deleted,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.isSelected});

  Lineitem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    product = json['product'];
    vendor = json['vendor'];
    name = json['name'];
    media = json['media'];
    qty = json['qty'];
    amount = json['amount'];
    totals = json['totals'] != null ? Totals.fromJson(json['totals']) : null;
    paymentStatus = json['paymentStatus'];
    fulfilmentStatus = json['fulfilmentStatus'];
    deliveryStatus = json['deliveryStatus'];
    returnStatus = json['returnStatus'];
    discountPercentage = json['discountPercentage'];
    couponPercentage = json['couponPercentage'];
    variantName = json['variantName'];
    customShipping = json['customShipping'];
    type = json['type'];
    category = json['category'];
    sku = json['sku'];
    barcode = json['barcode'];
    weight = json['weight'];
    dimensions = json['dimensions'] != null
        ? Dimensions.fromJson(json['dimensions'])
        : null;
    assignedRider = json['assignedRider'] != null
        ? Customer.fromJson(json['assignedRider'])
        : null;
    if (json['timeline'] != null) {
      timeline = <Timeline>[];
      json['timeline'].forEach((v) {
        timeline!.add(Timeline.fromJson(v));
      });
    }
    deleted = json['deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['product'] = product;
    data['vendor'] = vendor;
    data['name'] = name;
    data['media'] = media;
    data['qty'] = qty;
    data['amount'] = amount;
    if (totals != null) {
      data['totals'] = totals!.toJson();
    }
    data['paymentStatus'] = paymentStatus;
    data['fulfilmentStatus'] = fulfilmentStatus;
    data['deliveryStatus'] = deliveryStatus;
    data['returnStatus'] = returnStatus;
    data['discountPercentage'] = discountPercentage;
    data['couponPercentage'] = couponPercentage;
    data['variantName'] = variantName;
    data['customShipping'] = customShipping;
    data['type'] = type;
    data['category'] = category;
    data['sku'] = sku;
    data['barcode'] = barcode;
    data['weight'] = weight;
    if (dimensions != null) {
      data['dimensions'] = dimensions!.toJson();
    }
    if (assignedRider != null) {
      data['assignedRider'] = assignedRider!.toJson();
    }
    if (timeline != null) {
      data['timeline'] = timeline!.map((v) => v.toJson()).toList();
    }
    data['deleted'] = deleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Totals {
  int? subTotal;
  int? tax;
  int? shipping;
  int? coupon;
  int? total;

  Totals({this.subTotal, this.tax, this.shipping, this.coupon, this.total});

  Totals.fromJson(Map<String, dynamic> json) {
    subTotal = json['subTotal'];
    tax = json['tax'];
    shipping = json['shipping'];
    coupon = json['coupon'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subTotal'] = subTotal;
    data['tax'] = tax;
    data['shipping'] = shipping;
    data['coupon'] = coupon;
    data['total'] = total;
    return data;
  }
}

class Dimensions {
  int? width;
  int? height;
  int? length;

  Dimensions({this.width, this.height, this.length});

  Dimensions.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    height = json['height'];
    length = json['length'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['width'] = width;
    data['height'] = height;
    data['length'] = length;
    return data;
  }
}

class Timeline {
  String? status;
  String? dated;
  String? user;
  String? sId;

  Timeline({this.status, this.dated, this.user, this.sId});

  Timeline.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    dated = json['dated'];
    user = json['user'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['dated'] = dated;
    data['user'] = user;
    data['_id'] = sId;
    return data;
  }
}

class OrderDetails {
  int? couponPercentage;
  String? market;
  String? channel;
  String? notes;

  OrderDetails({this.couponPercentage, this.market, this.channel, this.notes});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    couponPercentage = json['couponPercentage'];
    market = json['market'];
    channel = json['channel'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['couponPercentage'] = couponPercentage;
    data['market'] = market;
    data['channel'] = channel;
    data['notes'] = notes;
    return data;
  }
}

class ShippingMethod {
  String? sId;
  String? type;
  int? amount;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ShippingMethod(
      {this.sId,
      this.type,
      this.amount,
      this.deleted,
      this.createdAt,
      this.updatedAt,
      this.iV});

  ShippingMethod.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
    amount = json['amount'];
    deleted = json['deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['type'] = type;
    data['amount'] = amount;
    data['deleted'] = deleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class OrderTotals {
  int? subTotal;
  int? tax;
  int? discount;
  int? shipping;
  int? coupon;
  int? total;

  OrderTotals(
      {this.subTotal,
      this.tax,
      this.discount,
      this.shipping,
      this.coupon,
      this.total});

  OrderTotals.fromJson(Map<String, dynamic> json) {
    subTotal = json['subTotal'];
    tax = json['tax'];
    discount = json['discount'];
    shipping = json['shipping'];
    coupon = json['coupon'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subTotal'] = subTotal;
    data['tax'] = tax;
    data['discount'] = discount;
    data['shipping'] = shipping;
    data['coupon'] = coupon;
    data['total'] = total;
    return data;
  }
}
