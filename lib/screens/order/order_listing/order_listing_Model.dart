class OrderItem {
  String? sId;
  String? customer;
  ContactInfo? contactInfo;
  Address? address;
  int? lineitems;
  String? status;
  OrderDetails? orderDetails;
  String? paymentType;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  String? orderId;
  int? iV;
  Totals? totals;
  String? paymentStatus;
  String? fulfilmentStatus;
  String? deliveryStatus;
  String? returnStatus;
  int? quantity;

  OrderItem(
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

  OrderItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customer = json['customer'];
    contactInfo = json['contactInfo'] != null
        ? ContactInfo.fromJson(json['contactInfo'])
        : null;
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    lineitems = json['lineitems'];
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
    data['lineitems'] = lineitems;
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
  int? subtotal;
  int? tax;
  double? discount;
  int? shipping;
  int? coupon;
  double? total;

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
