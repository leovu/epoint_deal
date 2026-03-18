

import 'package:epoint_deal_plugin/model/response/project_brand_response_model.dart';
import 'package:epoint_deal_plugin/model/response/project_department_response_model.dart';
import 'package:epoint_deal_plugin/model/response/project_position_response_model.dart';
import 'package:epoint_deal_plugin/model/response/project_role_response_model.dart';

class ProjectListMemberResponseModel {
  List<ProjectListMemberModel>? data;

  ProjectListMemberResponseModel({this.data});

  ProjectListMemberResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <ProjectListMemberModel>[];
      json.forEach((v) {
        data!.add(new ProjectListMemberModel.fromJson(v));
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

class ProjectListMemberModel {
  int? manageProjectStaffId;
  int? manageProjectId;
  int? staffId;
  int? roleId;
  String? roleName;
  int? departmentId;
  int? branchId;
  String? fullName;
  String? gender;
  String? phone1;
  String? email;
  String? staffAvatar;
  int? staffTitleId;
  String? staffTitleName;
  String? slug;
  String? staffTitleCode;

  ProjectListMemberModel(
      {this.manageProjectStaffId,
        this.manageProjectId,
        this.staffId,
        this.roleId,
        this.roleName,
        this.departmentId,
        this.branchId,
        this.fullName,
        this.gender,
        this.phone1,
        this.email,
        this.staffAvatar,
        this.staffTitleId,
        this.staffTitleName,
        this.slug,
        this.staffTitleCode});

  ProjectListMemberModel.fromJson(Map<String, dynamic> json) {
    manageProjectStaffId = json['manage_project_staff_id'];
    manageProjectId = json['manage_project_id'];
    staffId = json['staff_id'];
    roleId = json['role_id'];
    roleName = json['role_name'];
    departmentId = json['department_id'];
    branchId = json['branch_id'];
    fullName = json['full_name'];
    gender = json['gender'];
    phone1 = json['phone1'];
    email = json['email'];
    staffAvatar = json['staff_avatar'];
    staffTitleId = json['staff_title_id'];
    staffTitleName = json['staff_title_name'];
    slug = json['slug'];
    staffTitleCode = json['staff_title_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_project_staff_id'] = this.manageProjectStaffId;
    data['manage_project_id'] = this.manageProjectId;
    data['staff_id'] = this.staffId;
    data['role_id'] = this.roleId;
    data['role_name'] = this.roleName;
    data['department_id'] = this.departmentId;
    data['branch_id'] = this.branchId;
    data['full_name'] = this.fullName;
    data['gender'] = this.gender;
    data['phone1'] = this.phone1;
    data['email'] = this.email;
    data['staff_avatar'] = this.staffAvatar;
    data['staff_title_id'] = this.staffTitleId;
    data['staff_title_name'] = this.staffTitleName;
    data['slug'] = this.slug;
    data['staff_title_code'] = this.staffTitleCode;
    return data;
  }
}

class MemberFilterModel{
  ProjectDepartmentModel? departmentId;
  ProjectBranchModel? branchId;
  ProjectRoleModel? projectRoleId;
  ProjectPositionModel? staffTitleId;
  MemberFilterModel({this.departmentId, this.branchId, this.projectRoleId, this.staffTitleId});
}