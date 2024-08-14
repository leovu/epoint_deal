class TicketRatingDetailResponseModel {
  int? ticketRatingId;
  int? point;
  String? description;
  String? customerRating;
  String? ratingDate;

  TicketRatingDetailResponseModel(
      {this.ticketRatingId,
        this.point,
        this.description,
        this.customerRating,
        this.ratingDate});

  TicketRatingDetailResponseModel.fromJson(Map<String, dynamic> json) {
    ticketRatingId = json['ticket_rating_id'];
    point = json['point'];
    description = json['description'];
    customerRating = json['customer_rating'];
    ratingDate = json['rating_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_rating_id'] = this.ticketRatingId;
    data['point'] = this.point;
    data['description'] = this.description;
    data['customer_rating'] = this.customerRating;
    data['rating_date'] = this.ratingDate;
    return data;
  }
}