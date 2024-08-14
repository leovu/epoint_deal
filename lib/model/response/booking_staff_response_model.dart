class BookingStaffResponseModel {
  List<BookingStaffModel>? data;

  BookingStaffResponseModel({this.data});

  BookingStaffResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <BookingStaffModel>[];
      json.forEach((v) {
        data!.add(new BookingStaffModel.fromJson(v));
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

class BookingStaffModel {
  int? staffId;
  String? departmentName;
  String? branchName;
  String? staffTitleName;
  String? fullName;
  String? birthday;
  String? gender;
  String? phone1;
  String? phone2;
  String? email;
  String? facebook;
  String? dateLastLogin;
  String? staffAvatar;
  String? address;
  late bool selected;

  BookingStaffModel(
      {this.staffId,
        this.departmentName,
        this.branchName,
        this.staffTitleName,
        this.fullName,
        this.birthday,
        this.gender,
        this.phone1,
        this.phone2,
        this.email,
        this.facebook,
        this.dateLastLogin,
        this.staffAvatar,
        this.address,
        this.selected = false});

  BookingStaffModel.fromJson(Map<String, dynamic> json) {
    staffId = json['staff_id'];
    departmentName = json['department_name'];
    branchName = json['branch_name'];
    staffTitleName = json['staff_title_name'];
    fullName = json['full_name'];
    birthday = json['birthday'];
    gender = json['gender'];
    phone1 = json['phone1'];
    phone2 = json['phone2'];
    email = json['email'];
    facebook = json['facebook'];
    dateLastLogin = json['date_last_login'];
    staffAvatar = json['staff_avatar'];
    address = json['address'];
    selected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staff_id'] = this.staffId;
    data['department_name'] = this.departmentName;
    data['branch_name'] = this.branchName;
    data['staff_title_name'] = this.staffTitleName;
    data['full_name'] = this.fullName;
    data['birthday'] = this.birthday;
    data['gender'] = this.gender;
    data['phone1'] = this.phone1;
    data['phone2'] = this.phone2;
    data['email'] = this.email;
    data['facebook'] = this.facebook;
    data['date_last_login'] = this.dateLastLogin;
    data['staff_avatar'] = this.staffAvatar;
    data['address'] = this.address;
    return data;
  }
}
