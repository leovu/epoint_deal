class RoomResponseModel {
  List<RoomModel>? data;

  RoomResponseModel({this.data});

  RoomResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <RoomModel>[];
      json.forEach((v) {
        data!.add(new RoomModel.fromJson(v));
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

class RoomModel {
  int? roomId;
  String? name;
  int? seat;

  RoomModel({this.roomId, this.name, this.seat});

  RoomModel.fromJson(Map<String, dynamic> json) {
    roomId = json['room_id'];
    name = json['name'];
    seat = json['seat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_id'] = this.roomId;
    data['name'] = this.name;
    data['seat'] = this.seat;
    return data;
  }
}
