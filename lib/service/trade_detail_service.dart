import 'dart:convert';
import 'package:bottle_task/constants/apis.dart';
import 'package:bottle_task/models/gainer_looser_model.dart';
import 'package:bottle_task/models/trade_detail_model.dart';
import 'package:http/http.dart' as http;

Future<List<TradeDetailModel>> fetchStockData() async {
  final response = await http.get(Uri.parse(tradeDetailDataAPI));

  if (response.statusCode == 200) {
    List<dynamic> responseData = json.decode(response.body)['response'];
    List<TradeDetailModel> stocks =
        responseData.map((data) => TradeDetailModel.fromJson(data)).toList();
    return stocks;
  } else {
    throw Exception('Failed to load stock data');
  }
}

Future<List<GainerModel>> fetchGainers({required String slugName}) async {
  final response = await http.get(Uri.parse("$topGainer/$slugName"));
  if (response.statusCode == 200) {
    List responseData = json.decode(response.body)['response'];
    List<GainerModel> gainers =
        responseData.map((data) => GainerModel.fromJson(data)).toList();
    return gainers;
  } else {
    throw Exception('Failed to load stock data');
  }
}

Future<List<GainerModel>> fetchLosers({required String slugName}) async {
  final response = await http.get(Uri.parse("$toplooser/$slugName"));
  if (response.statusCode == 200) {
    List responseData = json.decode(response.body)['response'];
    List<GainerModel> gainers =
        responseData.map((data) => GainerModel.fromJson(data)).toList();
    return gainers;
  } else {
    throw Exception('Failed to load stock data');
  }
}
