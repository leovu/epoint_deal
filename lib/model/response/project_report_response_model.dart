class ProjectReportResponseModel {

  List<PhaseReport>? phaseReport;
  List<BudgetReport>? budgetReport;
  List<OverviewReport>? overviewReport;
  MemberReport? memberReport;

  ProjectReportResponseModel(
      {this.phaseReport,
        this.budgetReport,
        this.overviewReport,
        this.memberReport});

  ProjectReportResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['phase_report'] != null) {
      phaseReport = <PhaseReport>[];
      json['phase_report'].forEach((v) {
        phaseReport!.add(new PhaseReport.fromJson(v));
      });
    }
    if (json['budget_report'] != null) {
      budgetReport = <BudgetReport>[];
      json['budget_report'].forEach((v) {
        budgetReport!.add(new BudgetReport.fromJson(v));
      });
    }
    if (json['overview_report'] != null) {
      overviewReport = <OverviewReport>[];
      json['overview_report'].forEach((v) {
        overviewReport!.add(new OverviewReport.fromJson(v));
      });
    }
    memberReport = json['member_report'] != null
        ? new MemberReport.fromJson(json['member_report'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.phaseReport != null) {
      data['phase_report'] = this.phaseReport!.map((v) => v.toJson()).toList();
    }
    if (this.budgetReport != null) {
      data['budget_report'] =
          this.budgetReport!.map((v) => v.toJson()).toList();
    }
    if (this.overviewReport != null) {
      data['overview_report'] =
          this.overviewReport!.map((v) => v.toJson()).toList();
    }
    if (this.memberReport != null) {
      data['member_report'] = this.memberReport!.toJson();
    }
    return data;
  }
}
class OverviewReport {
  String? departmentName;
  int? workAmount;
  String? color;

  OverviewReport({this.departmentName, this.workAmount, this.color});

  OverviewReport.fromJson(Map<String, dynamic> json) {
    departmentName = json['department_name'];
    workAmount = json['work_amount'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['department_name'] = this.departmentName;
    data['work_amount'] = this.workAmount;
    data['color'] = this.color;
    return data;
  }
}

class PhaseReport {
  String? phaseName;
  PhaseData? phaseData;

  PhaseReport({this.phaseName, this.phaseData});

  PhaseReport.fromJson(Map<String, dynamic> json) {
    phaseName = json['phase_name'];
    phaseData = json['phase_data'] != null
        ? new PhaseData.fromJson(json['phase_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phase_name'] = this.phaseName;
    if (this.phaseData != null) {
      data['phase_data'] = this.phaseData!.toJson();
    }
    return data;
  }
}
class PhaseData {
  int? processing;
  int? complete;

  PhaseData({this.processing, this.complete});

  PhaseData.fromJson(Map<String, dynamic> json) {
    processing = json['processing'];
    complete = json['complete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['processing'] = this.processing;
    data['complete'] = this.complete;
    return data;
  }
}
class BudgetReport {
  int? budget;
  int? revenue;
  int? spending;

  BudgetReport({this.budget, this.revenue, this.spending});

  BudgetReport.fromJson(Map<String, dynamic> json) {
    budget = json['budget'];
    revenue = json['revenue'];
    spending = json['spending'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['budget'] = this.budget;
    data['revenue'] = this.revenue;
    data['spending'] = this.spending;
    return data;
  }
}

class MemberReport {
  List<MemberDetail>? memberDetail;
  int? memberTotal;

  MemberReport({this.memberDetail, this.memberTotal});

  MemberReport.fromJson(Map<String, dynamic> json) {
    if (json['member_detail'] != null) {
      memberDetail = <MemberDetail>[];
      json['member_detail'].forEach((v) {
        memberDetail!.add(new MemberDetail.fromJson(v));
      });
    }
    memberTotal = json['member_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.memberDetail != null) {
      data['member_detail'] =
          this.memberDetail!.map((v) => v.toJson()).toList();
    }
    data['member_total'] = this.memberTotal;
    return data;
  }
}

class MemberDetail {
  String? memberPosition;
  int? memberAmount;
  String? color;

  MemberDetail({this.memberPosition, this.memberAmount, this.color});

  MemberDetail.fromJson(Map<String, dynamic> json) {
    memberPosition = json['member_position'];
    memberAmount = json['member_amount'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['member_position'] = this.memberPosition;
    data['member_amount'] = this.memberAmount;
    data['color'] = this.color;
    return data;
  }
}