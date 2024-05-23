import 'package:bottle_task/models/gainer_looser_model.dart';
import 'package:bottle_task/service/trade_detail_service.dart';
import 'package:flutter/material.dart';

class GainerLoserScreen extends StatelessWidget {
  final String slugName;
  final String stockName;
  const GainerLoserScreen({super.key, required this.slugName,required this.stockName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
             Text(
              stockName,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ), const SizedBox(
              height: 24,
            ),
            const Text(
              "Top Gainers",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 24,
            ),
            FutureBuilder(
              future: fetchGainers(slugName: slugName),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<GainerModel> topGainers = snapshot.data!;
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: topGainers.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 1 / 1.1,
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return GainerContainer(gainer: topGainers[index]);
                    },
                  );
                }
              },
            ),
            const SizedBox(
              height: 32,
            ),
            const Text(
              "Top Loosers",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 24,
            ),
            FutureBuilder(
              future: fetchLosers(slugName: slugName),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<GainerModel> topLosers = snapshot.data!;
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: topLosers.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 1 / 1.1,
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return GainerContainer(gainer: topLosers[index]);
                    },
                  );
                }
              },
            ),
            const SizedBox(
              height: 24,
            )
          ],
        ),
      )),
    );
  }
}

class GainerContainer extends StatelessWidget {
  final GainerModel gainer;
  const GainerContainer({super.key, required this.gainer});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(width: 1, color: Colors.grey)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          gainer.ticker,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(gainer.tickerName,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        const SizedBox(
          height: 8,
        ),
        Text(
          gainer.latestPrice.toString(),
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: gainer.pointChange < 0 ? Colors.red : Colors.green),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          gainer.pointChange.toString() + " %",
          style: TextStyle(
              color: gainer.pointChange < 0 ? Colors.red : Colors.green),
        ),
      ]),
    );
  }
}

// class LooserContainer extends StatelessWidget {
//   final LooserModel looser;
//   const LooserContainer({super.key, required this.looser});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(24),
//           border: Border.all(width: 1, color: Colors.grey)),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Text(
//           looser.ticker,
//           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(
//           height: 4,
//         ),
//         Text(looser.tickerName,
//             style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
//         const SizedBox(
//           height: 8,
//         ),
//         Text(
//           looser.latestPrice.toString(),
//           style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: looser.pointChange < 0 ? Colors.red : Colors.green),
//         ),
//         const SizedBox(
//           height: 4,
//         ),
//         Text(
//           looser.pointChange.toString() + " %",
//           style: TextStyle(
//               color: looser.pointChange < 0 ? Colors.red : Colors.green),
//         ),
//       ]),
//     );
//   }
// }
