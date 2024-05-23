// import 'package:fl_chart/fl_chart.dart';
import 'package:bottle_task/widgets/line_chart_widget.dart';
import 'package:flutter/material.dart';

class TradeDetailContainer extends StatelessWidget {
  final String indicesName;
  final String latestPrice;
  final String slugName;
  final Color? color;
  final num pointChange;

  const TradeDetailContainer({
    Key? key,
    this.color,
    required this.slugName,
    required this.indicesName,
    required this.latestPrice,
    required this.pointChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color ?? Colors.white,
          boxShadow: const [
            BoxShadow(offset: Offset(0, 0), color: Colors.grey, blurRadius: 4)
          ]),
      padding: const EdgeInsets.all(12),
      width: 230,
      child: Row(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              indicesName,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            Text(
              latestPrice,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: pointChange < 0 ? Colors.red : Colors.green),
            ),
            Text(
              "$pointChange %",
              style: TextStyle(
                  fontSize: 15,
                  color: pointChange < 0 ? Colors.red : Colors.green),
            ),
          ],
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
            child: LineChartSample(
          pointChange: pointChange,
          slugName: slugName,
        ))
        // LineChart(LineChartData())
      ]),
    );
  }
}
