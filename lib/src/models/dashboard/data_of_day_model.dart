class DataOfDayModel {
  DataOfDayModel({
      this.error, 
      this.status, 
      this.message, 
      this.data,});

  DataOfDayModel.fromJson(dynamic json) {
    error = json['error'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? error;
  num? status;
  String? message;
  Data? data;
DataOfDayModel copyWith({  bool? error,
  num? status,
  String? message,
  Data? data,
}) => DataOfDayModel(  error: error ?? this.error,
  status: status ?? this.status,
  message: message ?? this.message,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      this.maxMin, 
      this.count, 
      this.lastUpdated,});

  Data.fromJson(dynamic json) {
    maxMin = json['maxMin'];
    count = json['count'] != null ? Count.fromJson(json['count']) : null;
    lastUpdated = json['lastUpdated'];
  }
  dynamic maxMin;
  Count? count;
  String? lastUpdated;
Data copyWith({  dynamic maxMin,
  Count? count,
  String? lastUpdated,
}) => Data(  maxMin: maxMin ?? this.maxMin,
  count: count ?? this.count,
  lastUpdated: lastUpdated ?? this.lastUpdated,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['maxMin'] = maxMin;
    if (count != null) {
      map['count'] = count?.toJson();
    }
    map['lastUpdated'] = lastUpdated;
    return map;
  }

}

class Count {
  Count({
      this.male, 
      this.female,});

  Count.fromJson(dynamic json) {
    male = json['male'];
    female = json['female'];
  }
  num? male;
  num? female;
Count copyWith({  num? male,
  num? female,
}) => Count(  male: male ?? this.male,
  female: female ?? this.female,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['male'] = male;
    map['female'] = female;
    return map;
  }

}