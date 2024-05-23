class GainerModel {
  final String ticker;
  final String tickerName;
  final num latestPrice;
  final double pointChange;
  final double percentageChange;
  final String sector;

  GainerModel({
    required this.ticker,
    required this.tickerName,
    required this.latestPrice,
    required this.pointChange,
    required this.percentageChange,
    required this.sector,
  });

  factory GainerModel.fromJson(Map<String, dynamic> json) {
    return GainerModel(
      ticker: json['ticker'],
      tickerName: json['ticker_name'],
      latestPrice: json['latest_price'],
      pointChange: json['point_change'].toDouble(),
      percentageChange: json['percentage_change'].toDouble(),
      sector: json['sector'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticker': ticker,
      'ticker_name': tickerName,
      'latest_price': latestPrice,
      'point_change': pointChange,
      'percentage_change': percentageChange,
      'sector': sector,
    };
  }
}

// class LooserModel {
//   final String ticker;
//   final String tickerName;
//   final num latestPrice;
//   final double pointChange;
//   final double percentageChange;
//   final String sector;

//   LooserModel({
//     required this.ticker,
//     required this.tickerName,
//     required this.latestPrice,
//     required this.pointChange,
//     required this.percentageChange,
//     required this.sector,
//   });

//   factory LooserModel.fromJson(Map<String, dynamic> json) {
//     return LooserModel(
//       ticker: json['ticker'],
//       tickerName: json['ticker_name'],
//       latestPrice: json['latest_price'],
//       pointChange: json['point_change'].toDouble(),
//       percentageChange: json['percentage_change'].toDouble(),
//       sector: json['sector'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'ticker': ticker,
//       'ticker_name': tickerName,
//       'latest_price': latestPrice,
//       'point_change': pointChange,
//       'percentage_change': percentageChange,
//       'sector': sector,
//     };
//   }
// }
