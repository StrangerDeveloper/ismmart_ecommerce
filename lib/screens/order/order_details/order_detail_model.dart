class OrderItemIdModel {
  String? sId;
  String? customer;
  ContactInfo? contactInfo;
  Address? address;
  List<Lineitems>? lineitems;
  String? status;
  OrderDetails? orderDetails;
  String? paymentType;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  String? orderId;
  num? iV;
  Totals? totals;
  String? paymentStatus;
  String? fulfilmentStatus;
  String? deliveryStatus;
  String? returnStatus;
  num? quantity;

  OrderItemIdModel(
      {this.sId,
      this.customer,
      this.contactInfo,
      this.address,
      this.lineitems,
      this.status,
      this.orderDetails,
      this.paymentType,
      this.deleted,
      this.createdAt,
      this.updatedAt,
      this.orderId,
      this.iV,
      this.totals,
      this.paymentStatus,
      this.fulfilmentStatus,
      this.deliveryStatus,
      this.returnStatus,
      this.quantity});

  OrderItemIdModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customer = json['customer'];
    contactInfo = json['contactInfo'] != null
        ? ContactInfo.fromJson(json['contactInfo'])
        : null;
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    // if (json['lineitems'] != null) {
    //   lineitems = <Lineitems>[];
    //   json['lineitems'].forEach((v) {
    //     lineitems!.add(Lineitems.fromJson(v));
    //   });
    // }
    // print("lineitems" + lineitems.toString());
    status = json['status'];
    orderDetails = json['orderDetails'] != null
        ? OrderDetails.fromJson(json['orderDetails'])
        : null;
    paymentType = json['paymentType'];
    deleted = json['deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    orderId = json['orderId'];
    iV = json['__v'];
    totals = json['totals'] != null ? Totals.fromJson(json['totals']) : null;
    paymentStatus = json['paymentStatus'];
    fulfilmentStatus = json['fulfilmentStatus'];
    deliveryStatus = json['deliveryStatus'];
    returnStatus = json['returnStatus'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['customer'] = customer;
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
    data['quantity'] = quantity;
    return data;
  }
}

class ContactInfo {
  String? name;
  String? email;

  ContactInfo({this.name, this.email});

  ContactInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
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

  Shipping({this.city, this.country, this.address});

  Shipping.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    country = json['country'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    data['country'] = country;
    data['address'] = address;
    return data;
  }
}

class Lineitems {
  String? sId;
  String? product;
  String? variant;
  String? inventory;
  String? vendor;
  String? store;
  String? shipment;
  String? name;
  List<Media>? media;
  num? quantity;
  LineItemTotals? lineItemTotals;
  String? paymentStatus;
  String? fulfilmentStatus;
  String? deliveryStatus;
  String? returnStatus;
  num? discountPercentage;
  String? variantName;
  //List<Stream>? variantMedia;
  String? storeName;
  List<String>? options;
  num? weight;
  bool? deleted;
  List<String>? timeline;
  num? iV;
  String? createdAt;
  String? updatedAt;

  Lineitems(
      {this.sId,
      this.product,
      this.variant,
      this.inventory,
      this.vendor,
      this.store,
      this.shipment,
      this.name,
      this.media,
      this.quantity,
      this.lineItemTotals,
      this.paymentStatus,
      this.fulfilmentStatus,
      this.deliveryStatus,
      this.returnStatus,
      this.discountPercentage,
      this.variantName,
      //this.variantMedia,
      this.storeName,
      this.options,
      this.weight,
      this.deleted,
      this.timeline,
      this.iV,
      this.createdAt,
      this.updatedAt});

  Lineitems.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    product = json['product'];
    variant = json['variant'];
    inventory = json['inventory'];
    vendor = json['vendor'];
    store = json['store'];
    shipment = json['shipment'];
    name = json['name'];
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(Media.fromJson(v));
      });
    }
    // print("media" + media.toString());
    quantity = json['quantity'];
    lineItemTotals =
        json['totals'] != null ? LineItemTotals.fromJson(json['totals']) : null;
    paymentStatus = json['paymentStatus'];
    fulfilmentStatus = json['fulfilmentStatus'];
    deliveryStatus = json['deliveryStatus'];
    returnStatus = json['returnStatus'];
    discountPercentage = json['discountPercentage'];
    variantName = json['variantName'];
    // if (json['variantMedia'] != null) {
    //   variantMedia = <String>[];
    //   json['variantMedia'].forEach((v) {
    //     variantMedia!.add(v);
    //   });
    // }
    // print("variantMedia" + variantMedia.toString());
    storeName = json['storeName'];
    options = json['options'] != null ? json['options'].cast<String>() : null;
    weight = json['weight'];
    deleted = json['deleted'];
    // if (json['timeline'] != null) {
    //   timeline = <Null>[];
    //   json['timeline'].forEach((v) {
    //     timeline!.add(v);
    //   });
    // }
    // print("json['__v']" + json['__v'].toString());
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['product'] = product;
    data['variant'] = variant;
    data['inventory'] = inventory;
    data['vendor'] = vendor;
    data['store'] = store;
    data['shipment'] = shipment;
    data['name'] = name;
    if (media != null) {
      data['media'] = media!.map((v) => v.toJson()).toList();
    }
    data['quantity'] = quantity;
    if (lineItemTotals != null) {
      data['totals'] = lineItemTotals!.toJson();
    }
    data['paymentStatus'] = paymentStatus;
    data['fulfilmentStatus'] = fulfilmentStatus;
    data['deliveryStatus'] = deliveryStatus;
    data['returnStatus'] = returnStatus;
    data['discountPercentage'] = discountPercentage;
    data['variantName'] = variantName;
    // if (variantMedia != null) {
    //   data['variantMedia'] = variantMedia!;
    // }
    data['storeName'] = storeName;
    data['options'] = options;
    data['weight'] = weight;
    data['deleted'] = deleted;
    if (timeline != null) {
      data['timeline'] = timeline!;
    }
    data['__v'] = iV;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Media {
  String? url;
  bool? thumbnail;
  String? type;
  String? sId;

  Media({this.url, this.thumbnail, this.type, this.sId});

  Media.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    thumbnail = json['thumbnail'];
    type = json['type'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['thumbnail'] = thumbnail;
    data['type'] = type;
    data['_id'] = sId;
    return data;
  }
}

class LineItemTotals {
  num? subtotal;
  num? discount;
  num? shipping;
  num? total;

  LineItemTotals({this.subtotal, this.discount, this.shipping, this.total});

  LineItemTotals.fromJson(Map<String, dynamic> json) {
    subtotal = json['subtotal'];
    discount = json['discount'];
    shipping = json['shipping'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subtotal'] = subtotal;
    data['discount'] = discount;
    data['shipping'] = shipping;
    data['total'] = total;
    return data;
  }
}

class OrderDetails {
  String? channel;
  String? market;

  OrderDetails({this.channel, this.market});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    channel = json['channel'];
    market = json['market'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['channel'] = channel;
    data['market'] = market;
    return data;
  }
}

class Totals {
  num? subtotal;
  num? tax;
  num? discount;
  num? shipping;
  num? coupon;
  num? total;

  Totals(
      {this.subtotal,
      this.tax,
      this.discount,
      this.shipping,
      this.coupon,
      this.total});

  Totals.fromJson(Map<String, dynamic> json) {
    subtotal = json['subtotal'];
    tax = json['tax'];
    discount = json['discount'];
    shipping = json['shipping'];
    coupon = json['coupon'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subtotal'] = subtotal;
    data['tax'] = tax;
    data['discount'] = discount;
    data['shipping'] = shipping;
    data['coupon'] = coupon;
    data['total'] = total;
    return data;
  }
}
