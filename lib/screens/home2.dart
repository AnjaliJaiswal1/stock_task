import 'package:bottle_task/models/trade_detail_model.dart';
import 'package:bottle_task/screens/gainer_looser_screen.dart';
import 'package:bottle_task/service/trade_detail_service.dart';
import 'package:bottle_task/widgets/line_chart_widget.dart';
import 'package:bottle_task/widgets/trade_detail_container.dart';
import 'package:flutter/material.dart';

class MyHomePage2 extends StatefulWidget {
  const MyHomePage2({super.key});

  @override
  State<MyHomePage2> createState() => _MyHomePage2State();
}

class _MyHomePage2State extends State<MyHomePage2> {
  ValueNotifier<String> slugNameNotifier = ValueNotifier<String>("nepse");
  ValueNotifier<String> stockNameNotifier = ValueNotifier<String>("NEPSE");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder<String>(
          valueListenable: slugNameNotifier,
          builder: (context, slugName, child) {
            return ValueListenableBuilder<String>(
              valueListenable: stockNameNotifier,
              builder: (context, stockName, child) {
                return GainerLoserScreen(
                    slugName: slugName, stockName: stockName);
              },
            );
          },
        ),
        bottomNavigationBar: SizedBox(
            height: 120,
            child: FutureBuilder<List<TradeDetailModel>>(
                future: fetchStockData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    List<TradeDetailModel> stocks = snapshot.data!;

                    return Stack(
                      children: [
                        ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 4,
                          ),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: stocks.length,
                          itemBuilder: (context, index) {
                            TradeDetailModel stock = stocks[index];
                            return InkWell(
                              onTap: () {
                                slugNameNotifier.value = stock.slug;
                                stockNameNotifier.value = stock.indicesName;
                              },
                              child: TradeDetailContainer(
                                slugName: stock.slug,
                                indicesName: stock.indicesName,
                                latestPrice: stock.latestPrice.toString(),
                                pointChange: stock.pointChange ?? 0,
                              ),
                            );
                          },
                        ),
                        Positioned(
                            bottom: 0,
                            left: 0,
                            child: Container(
                              height: 120,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 77, 143, 80),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 0),
                                        color: Colors.grey,
                                        blurRadius: 4)
                                  ]),
                              padding: const EdgeInsets.all(12),
                              width: 200,
                              child: Row(children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      stocks[0].indicesName,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      stocks[0].latestPrice,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: stocks[0].pointChange! < 0
                                              ? Colors.red
                                              : Colors.white),
                                    ),
                                    Text(
                                      "${stocks[0].pointChange} %",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: stocks[0].pointChange! < 0
                                              ? Colors.red
                                              : Colors.white),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 24,
                                ),
                                Expanded(
                                    child: LineChartSample(
                                  color: Colors.white,
                                  pointChange: stocks[0].pointChange!,
                                  slugName: stocks[0].slug,
                                ))
                                // LineChart(LineChartData())
                              ]),
                            )
                            // child: TradeDetailContainer(
                            //     color: Colors.green,
                            //     indicesName: stocks[0].indicesName,
                            //     latestPrice: stocks[0].latestPrice,
                            //     pointChange: stocks[0].pointChange ?? 0)
                            )
                      ],
                    );
                  }
                })));
  }
}
