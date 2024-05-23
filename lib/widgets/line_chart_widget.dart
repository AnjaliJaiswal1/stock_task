// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// class LineChartWidget extends StatelessWidget {
//   final List<FlSpot> data;

//   const LineChartWidget({super.key, required this.data});

//   @override
//   Widget build(BuildContext context) {
//     return LineChart(
//       LineChartData(
//         lineBarsData: [
//           LineChartBarData(
//             spots: data,
//             isCurved: true,
//             // colors: [Colors.blue],
//             barWidth: 4,
//             isStrokeCapRound: true,
//             belowBarData: BarAreaData(show: false),
//           ),
//         ],
//         minY: 2090, // Adjust this value based on your data
//         titlesData: const FlTitlesData(
//           bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//           leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true))

//         ),
//         borderData: FlBorderData(show: true),
//         gridData: FlGridData(show: true),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:developer';
import 'package:bottle_task/constants/apis.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LineChartSample extends StatefulWidget {
  final String slugName;
  final num pointChange;
  final Color? color;
  const LineChartSample(
      {super.key,
      required this.slugName,
      required this.pointChange,
      this.color});

  @override
  State<LineChartSample> createState() => _LineChartSampleState();
}

class _LineChartSampleState extends State<LineChartSample> {
  List response = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = "$chartRenderAPI/${widget.slugName}";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['response'] as List;
        setState(() {
          this.response = data
              .map((item) => {
                    'value': item['value'],
                    'timestamp': item['timestamp'],
                  })
              .toList();
          isLoading = false;
        });
      } else {
        setState(() {
          hasError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      log(e.toString());
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : hasError
              ? const Center(child: Text('Error fetching data'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LineChart(
                    LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                          color: widget.color ??
                              (widget.pointChange < 0
                                  ? Colors.red
                                  : Colors.green),
                          spots: response
                              .asMap()
                              .map((index, data) {
                                final time = DateTime.parse(data['timestamp']);
                                final value = data['value'].toDouble();
                                return MapEntry(
                                    index, FlSpot(index.toDouble(), value));
                              })
                              .values
                              .toList(),
                          isCurved: true,
                          barWidth: 2,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: false),
                        ),
                      ],
                      titlesData: const FlTitlesData(
                        topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                            reservedSize: 22,
                          ),
                        ),
                        leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                      ),
                      borderData: FlBorderData(
                        show: false,
                        border: Border.all(color: Colors.black),
                      ),
                    ),
                  ),
                ),
    );
  }
}
