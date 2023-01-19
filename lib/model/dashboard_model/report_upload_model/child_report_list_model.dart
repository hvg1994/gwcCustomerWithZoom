class ChildReportListModel {
  int? id;
  String? doctorId;
  String? patientId;
  String? appointmentId;
  String? report;
  String? reportType;
  String? reportId;
  String? type;
  String? isArchieved;
  String? createdAt;
  String? updatedAt;

  ChildReportListModel(
      {this.id,
        this.doctorId,
        this.patientId,
        this.appointmentId,
        this.report,
        this.reportType,
        this.reportId,
        this.type,
        this.isArchieved,
        this.createdAt,
        this.updatedAt});

  ChildReportListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorId = json['doctor_id'];
    patientId = json['patient_id'];
    appointmentId = json['appointment_id'];
    report = json['report'];
    reportType = json['report_type'];
    reportId = json['report_id'];
    type = json['type'];
    isArchieved = json['is_archieved'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctor_id'] = this.doctorId;
    data['patient_id'] = this.patientId;
    data['appointment_id'] = this.appointmentId;
    data['report'] = this.report;
    data['report_type'] = this.reportType;
    data['report_id'] = this.reportId;
    data['type'] = this.type;
    data['is_archieved'] = this.isArchieved;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}