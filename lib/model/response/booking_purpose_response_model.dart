class BookingPurposeResponseModel {
  List<BookingPurposeModel>? data;

  BookingPurposeResponseModel({this.data});

  BookingPurposeResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <BookingPurposeModel>[];
      json.forEach((v) {
        data!.add(new BookingPurposeModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookingPurposeModel {
  int? id;
  String? name;
  String? description;
  int? position;

  BookingPurposeModel({this.id, this.name, this.description, this.position});

  BookingPurposeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['position'] = this.position;
    return data;
  }
}
