class ChangePasswordRequestModel {
  String? password;
  String? newPassword;
  String? confirmPassword;

  ChangePasswordRequestModel({this.password, this.newPassword, this.confirmPassword});

  ChangePasswordRequestModel.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    newPassword = json['new_password'];
    confirmPassword = json['confirm_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
    data['new_password'] = this.newPassword;
    data['confirm_password'] = this.confirmPassword;
    return data;
  }
}
