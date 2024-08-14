class WarrantyUpdateRequestModel {
  String? warrantyCardCode;
  String? status;
  String? objectSerial;
  String? objectNote;
  List<WarrantyUpdateImageModel>? warrantyImage;

  WarrantyUpdateRequestModel(
      {this.warrantyCardCode,
        this.status,
        this.objectSerial,
        this.objectNote,
        this.warrantyImage});

  WarrantyUpdateRequestModel.fromJson(Map<String, dynamic> json) {
    warrantyCardCode = json['warranty_card_code'];
    status = json['status'];
    objectSerial = json['object_serial'];
    objectNote = json['object_note'];
    if (json['warranty_image'] != null) {
      warrantyImage = <WarrantyUpdateImageModel>[];
      json['warranty_image'].forEach((v) {
        warrantyImage!.add(new WarrantyUpdateImageModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['warranty_card_code'] = this.warrantyCardCode;
    data['status'] = this.status;
    data['object_serial'] = this.objectSerial;
    data['object_note'] = this.objectNote;
    if (this.warrantyImage != null) {
      data['warranty_image'] =
          this.warrantyImage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WarrantyUpdateImageModel {
  String? link;

  WarrantyUpdateImageModel({this.link});

  WarrantyUpdateImageModel.fromJson(Map<String, dynamic> json) {
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    return data;
  }
}
