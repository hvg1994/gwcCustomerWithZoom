class ShippingApprovedModel {
  String? data;
  Value? value;

  ShippingApprovedModel(
      {this.data, this.value});

  ShippingApprovedModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    value = json['value'] != null ? new Value.fromJson(json['value']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    if (this.value != null) {
      data['value'] = this.value!.toJson();
    }
    return data;
  }
}

class Value {
  int? id;
  String? teamPatientId;
  String? orderId;
  String? shippingId;
  String? awbCode;
  String? courierName;
  String? courierCompanyId;
  String? assignedDateTime;
  String? labelUrl;
  String? manifestUrl;
  String? pickupTokenNumber;
  String? routingCode;
  String? pickupScheduledDate;
  String? status;
  String? addedBy;
  String? createdAt;
  String? updatedAt;

  Value(
      {this.id,
        this.teamPatientId,
        this.orderId,
        this.shippingId,
        this.awbCode,
        this.courierName,
        this.courierCompanyId,
        this.assignedDateTime,
        this.labelUrl,
        this.manifestUrl,
        this.pickupTokenNumber,
        this.routingCode,
        this.pickupScheduledDate,
        this.status,
        this.addedBy,
        this.createdAt,
        this.updatedAt});

  Value.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamPatientId = json['team_patient_id'];
    orderId = json['order_id'];
    shippingId = json['shipping_id'];
    awbCode = json['awb_code'];
    courierName = json['courier_name'];
    courierCompanyId = json['courier_company_id'];
    assignedDateTime = json['assigned_date_time'];
    labelUrl = json['label_url'];
    manifestUrl = json['manifest_url'];
    pickupTokenNumber = json['pickup_token_number'];
    routingCode = json['routing_code'];
    pickupScheduledDate = json['pickup_scheduled_date'];
    status = json['status'];
    addedBy = json['added_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['team_patient_id'] = this.teamPatientId;
    data['order_id'] = this.orderId;
    data['shipping_id'] = this.shippingId;
    data['awb_code'] = this.awbCode;
    data['courier_name'] = this.courierName;
    data['courier_company_id'] = this.courierCompanyId;
    data['assigned_date_time'] = this.assignedDateTime;
    data['label_url'] = this.labelUrl;
    data['manifest_url'] = this.manifestUrl;
    data['pickup_token_number'] = this.pickupTokenNumber;
    data['routing_code'] = this.routingCode;
    data['pickup_scheduled_date'] = this.pickupScheduledDate;
    data['status'] = this.status;
    data['added_by'] = this.addedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}