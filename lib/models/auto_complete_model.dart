class AutoCompleteModel {
  List<Results>? results;


  AutoCompleteModel({this.results,});

  AutoCompleteModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Results {
  int? id;
  String? name;
  double? latitude;
  double? longitude;
  String? featureCode;
  String? countryCode;
  String? timezone;
  int? population;
  String? country;
  String? admin1;
  String? admin2;

  Results(
      {this.id,
      this.name,
      this.latitude,
      this.longitude,
      this.featureCode,
      this.countryCode,
      this.timezone,
      this.population,
      this.country,
      this.admin1,
      this.admin2,});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    featureCode = json['feature_code'];
    countryCode = json['country_code'];
    timezone = json['timezone'];
    population = json['population'];
    country = json['country'];
    admin1 = json['admin1'];
    admin2 = json['admin2'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['feature_code'] = this.featureCode;
    data['country_code'] = this.countryCode;
    data['timezone'] = this.timezone;
    data['population'] = this.population;
    data['country'] = this.country;
    data['admin1'] = this.admin1;
    data['admin2'] = this.admin2;
    return data;
  }
}
