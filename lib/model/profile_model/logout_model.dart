class LogoutModel {
  String? status;
  String? message;

  LogoutModel({this.status, this.message});

  LogoutModel.fromJson(Map<String, dynamic> json) {
    status = json['status_code'] ?? json['status'].toString();
    message = json['message'] ?? json['errorMsg'] ?? json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}