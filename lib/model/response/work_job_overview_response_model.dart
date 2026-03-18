import 'work_list_status_response_model.dart';

class WorkJobOverviewResponseModel {
  int? totalWork;
  int? totalWorkDay;
  List<WorkJobTotalModel>? total;
  WorkJobOverviewStaffModel? listStaffNoStartedWork;
  List<WorkJobOverviewModel>? listJob;

  WorkJobOverviewResponseModel(
      {this.totalWork,
        this.totalWorkDay,
        this.total,
        this.listStaffNoStartedWork,
        this.listJob});

  WorkJobOverviewResponseModel.fromJson(Map<String, dynamic> json) {
    totalWork = json['total_work'];
    totalWorkDay = json['total_work_day'];
    if (json['total'] != null) {
      total = <WorkJobTotalModel>[];
      json['total'].forEach((v) {
        total!.add(new WorkJobTotalModel.fromJson(v));
      });
    }
    listStaffNoStartedWork = json['list_staff_no_started_work'] != null
        ? new WorkJobOverviewStaffModel.fromJson(
        json['list_staff_no_started_work'])
        : null;
    if (json['list_job'] != null) {
      listJob = <WorkJobOverviewModel>[];
      json['list_job'].forEach((v) {
        listJob!.add(new WorkJobOverviewModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_work'] = this.totalWork;
    data['total_work_day'] = this.totalWorkDay;
    if (this.total != null) {
      data['total'] = this.total!.map((v) => v.toJson()).toList();
    }
    if (this.listStaffNoStartedWork != null) {
      data['list_staff_no_started_work'] = this.listStaffNoStartedWork!.toJson();
    }
    if (this.listJob != null) {
      data['list_job'] =
          this.listJob!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkJobTotalModel {
  int? id;
  int? total;
  int? isChart;
  String? title;
  String? color;

  WorkJobTotalModel({this.id, this.total, this.isChart, this.title, this.color});

  WorkJobTotalModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    isChart = json['is_chart'];
    title = json['title'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total'] = this.total;
    data['is_chart'] = this.isChart;
    data['title'] = this.title;
    data['color'] = this.color;
    return data;
  }
}

class WorkJobOverviewStaffModel {
  int? total;
  List<WorkJobStaffModel>? list;

  WorkJobOverviewStaffModel({this.total, this.list});

  WorkJobOverviewStaffModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['list'] != null) {
      list = <WorkJobStaffModel>[];
      json['list'].forEach((v) {
        list!.add(new WorkJobStaffModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkJobStaffModel {
  int? staffId;
  String? staffName;
  String? roleName;
  String? staffAvatar;
  int? manageWorkId;
  bool? isSelected;

  WorkJobStaffModel(
      {this.staffId, this.staffName, this.roleName, this.staffAvatar});

  WorkJobStaffModel.fromJson(Map<String, dynamic> json) {
    staffId = json['staff_id'];
    staffName = json['staff_name'];
    roleName = json['role_name'];
    staffAvatar = json['staff_avatar'];
    manageWorkId = json['manage_work_id'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staff_id'] = this.staffId;
    data['staff_name'] = this.staffName;
    data['role_name'] = this.roleName;
    data['staff_avatar'] = this.staffAvatar;
    data['manage_work_id'] = this.manageWorkId;
    return data;
  }
}

class WorkJobOverviewModel {
  String? textBlock;
  int? total;
  String? code;

  WorkJobOverviewModel({this.textBlock, this.total, this.code});

  WorkJobOverviewModel.fromJson(Map<String, dynamic> json) {
    textBlock = json['text_block'];
    total = json['total'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text_block'] = this.textBlock;
    data['total'] = this.total;
    data['code'] = this.code;
    return data;
  }
}

class WorkJobModel {
  int? manageWorkId;
  String? manageWorkTitle;
  double? progress;
  int? parentId;
  String? parentName;
  int? processorId;
  String? processorAvatar;
  String? processorName;
  int? assignorId;
  String? assignorName;
  String? assignorAvatar;
  int? approveId;
  String? approveName;
  String? approveAvatar;
  int? manageStatusId;
  String? manageStatusName;
  String? manageStatusColor;
  int? manageProjectId;
  String? manageProjectName;
  int? manageTypeWorkId;
  String? textOverdue;
  int? totalMessage;
  String? dateEnd;
  String? dateFinish;
  int? priority;
  String? priorityName;
  int? totalChildJob;
  List<WorkJobTagsModel>? tags;
  List<WorkJobStaffModel>? listStaff;
  List<WorkListStatusModel>? listStatus;
  int? isApprove;
  int? isEdit;
  bool? isSelected;

  WorkJobModel(
      {this.manageWorkId,
        this.manageWorkTitle,
        this.progress,
        this.parentId,
        this.parentName,
        this.processorId,
        this.processorAvatar,
        this.processorName,
        this.assignorId,
        this.assignorName,
        this.assignorAvatar,
        this.approveId,
        this.approveName,
        this.approveAvatar,
        this.manageStatusId,
        this.manageStatusName,
        this.manageStatusColor,
        this.manageProjectId,
        this.manageProjectName,
        this.manageTypeWorkId,
        this.textOverdue,
        this.totalMessage,
        this.dateEnd,
        this.dateFinish,
        this.priority,
        this.priorityName,
        this.totalChildJob,
        this.tags,
        this.listStaff,
        this.listStatus,
        this.isApprove,
        this.isEdit});

  WorkJobModel.fromJson(Map<String, dynamic> json) {
    manageWorkId = json['manage_work_id'];
    manageWorkTitle = json['manage_work_title'];
    progress = json['progress'] == null?null:double.tryParse(json['progress'].toString());
    parentId = json['parent_id'];
    parentName = json['parent_name'];
    processorId = json['processor_id'];
    processorAvatar = json['processor_avatar'];
    processorName = json['processor_name'];
    assignorId = json['assignor_id'];
    assignorName = json['assignor_name'];
    assignorAvatar = json['assignor_avatar'];
    approveId = json['approve_id'];
    approveName = json['approve_name'];
    approveAvatar = json['approve_avatar'];
    manageStatusId = json['manage_status_id'];
    manageStatusName = json['manage_status_name'];
    manageStatusColor = json['manage_status_color'];
    manageProjectId = json['manage_project_id'];
    manageProjectName = json['manage_project_name'];
    manageTypeWorkId = json['manage_type_work_id'];
    textOverdue = json['text_overdue'];
    totalMessage = json['total_message'];
    dateEnd = json['date_end'];
    dateFinish = json['date_finish'];
    priority = json['priority'];
    priorityName = json['priority_name'];
    totalChildJob = json['total_child_job'];
    if (json['tags'] != null) {
      tags = <WorkJobTagsModel>[];
      json['tags'].forEach((v) {
        tags!.add(new WorkJobTagsModel.fromJson(v));
      });
    }
    if (json['list_staff'] != null) {
      listStaff = <WorkJobStaffModel>[];
      json['list_staff'].forEach((v) {
        listStaff!.add(new WorkJobStaffModel.fromJson(v));
      });
    }
    if (json['list_status'] != null) {
      listStatus = <WorkListStatusModel>[];
      json['list_status'].forEach((v) {
        listStatus!.add(new WorkListStatusModel.fromJson(v));
      });
    }
    isApprove = json['is_approve'];
    isEdit = json['is_edit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_work_id'] = this.manageWorkId;
    data['manage_work_title'] = this.manageWorkTitle;
    data['progress'] = this.progress;
    data['parent_id'] = this.parentId;
    data['parent_name'] = this.parentName;
    data['processor_id'] = this.processorId;
    data['processor_avatar'] = this.processorAvatar;
    data['processor_name'] = this.processorName;
    data['assignor_id'] = this.assignorId;
    data['assignor_name'] = this.assignorName;
    data['assignor_avatar'] = this.assignorAvatar;
    data['approve_id'] = this.approveId;
    data['approve_name'] = this.approveName;
    data['approve_avatar'] = this.approveAvatar;
    data['manage_status_id'] = this.manageStatusId;
    data['manage_status_name'] = this.manageStatusName;
    data['manage_status_color'] = this.manageStatusColor;
    data['manage_project_id'] = this.manageProjectId;
    data['manage_project_name'] = this.manageProjectName;
    data['manage_type_work_id'] = this.manageTypeWorkId;
    data['text_overdue'] = this.textOverdue;
    data['total_message'] = this.totalMessage;
    data['date_end'] = this.dateEnd;
    data['date_finish'] = this.dateFinish;
    data['priority'] = this.priority;
    data['priority_name'] = this.priorityName;
    data['total_child_job'] = this.totalChildJob;
    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }
    if (this.listStaff != null) {
      data['list_staff'] = this.listStaff!.map((v) => v.toJson()).toList();
    }
    if (this.listStatus != null) {
      data['list_status'] = this.listStatus!.map((v) => v.toJson()).toList();
    }
    data['is_approve'] = this.isApprove;
    data['is_edit'] = this.isEdit;
    return data;
  }
}

class WorkJobTagsModel {
  String? manageTagName;
  String? manageTagIcon;

  WorkJobTagsModel({this.manageTagName, this.manageTagIcon});

  WorkJobTagsModel.fromJson(Map<String, dynamic> json) {
    manageTagName = json['manage_tag_name'];
    manageTagIcon = json['manage_tag_icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_tag_name'] = this.manageTagName;
    data['manage_tag_icon'] = this.manageTagIcon;
    return data;
  }
}