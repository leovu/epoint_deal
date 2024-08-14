class PageInfoModel {
  int? total;
  int? itemPerPage;
  int? from;
  int? to;
  int? currentPage;
  int? firstPage;
  int? lastPage;
  int? previousPage;
  int? nextPage;
  List<int>? pageRange;
  bool? enableLoadmore;

  PageInfoModel(
      {this.total,
        this.itemPerPage,
        this.from,
        this.to,
        this.currentPage,
        this.firstPage,
        this.lastPage,
        this.previousPage,
        this.nextPage,
        this.pageRange,
        this.enableLoadmore = false});

  PageInfoModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    itemPerPage = json['itemPerPage'];
    from = json['from'];
    to = json['to'];
    currentPage = json['currentPage'];
    firstPage = json['firstPage'];
    lastPage = json['lastPage'];
    previousPage = json['previousPage'];
    nextPage = json['nextPage'];
    pageRange = json['pageRange'] == null ? null : json['pageRange'] .cast<int>();
    enableLoadmore = (currentPage ?? 0) < (lastPage ?? 0);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['itemPerPage'] = this.itemPerPage;
    data['from'] = this.from;
    data['to'] = this.to;
    data['currentPage'] = this.currentPage;
    data['firstPage'] = this.firstPage;
    data['lastPage'] = this.lastPage;
    data['previousPage'] = this.previousPage;
    data['nextPage'] = this.nextPage;
    data['pageRange'] = this.pageRange;
    return data;
  }
}