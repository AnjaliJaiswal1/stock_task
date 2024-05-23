class TradeDetailModel {
  final String indicesName;
  final String slug;
  final String latestPrice;
  final num? pointChange;
  final num percentageChange;
  final DateTime calculatedOn;

  TradeDetailModel({
    required this.indicesName,
    required this.slug,
    required this.latestPrice,
    required this.pointChange,
    required this.percentageChange,
    required this.calculatedOn,
  });

  factory TradeDetailModel.fromJson(Map<String, dynamic> json) {
    return TradeDetailModel(
      indicesName: json['indices_name'],
      slug: json['slug'],
      latestPrice: json['latest_price'],
      pointChange: json['point_change']??0,
      percentageChange: json['percentage_change']??0,
      calculatedOn: DateTime.parse(json['calculated_on']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'indices_name': indicesName,
      'slug': slug,
      'latest_price': latestPrice,
      'point_change': pointChange,
      'percentage_change': percentageChange,
      'calculated_on': calculatedOn.toIso8601String(),
    };
  }
}
