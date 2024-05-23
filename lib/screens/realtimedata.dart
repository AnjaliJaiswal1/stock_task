import 'dart:developer';

import 'package:bottle_task/constants/apis.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:web_socket_channel/web_socket_channel.dart';

class RealTimeDataScreen extends StatefulWidget {
  const RealTimeDataScreen({super.key});

  @override
  State<RealTimeDataScreen> createState() => _RealTimeDataScreenState();
}

class _RealTimeDataScreenState extends State<RealTimeDataScreen> {
  late WebSocketChannel channel;

  @override
  void initState() {
    super.initState();
    channel = WebSocketChannel.connect(
      Uri.parse('wss://nepseapi.abcsecurities.com.np/smtm/indices-data'),
    );
  }

  // streamListener() {
  //   channel.stream.listen((message) {
  //     // channel.sink.add('received!');
  //     // channel.sink.close(status.goingAway);

  //     var getData = http.get(Uri.parse(tradeDetailDataAPI));

  //     log(message);
  //   });
  // }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real-time Data'),
      ),
      body: StreamBuilder(
        stream: channel.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            log(snapshot.error.toString());
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return Center(child: Text('Data: ${snapshot.data}'));
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}

class ApiService {
  final WebSocketChannel channel;

  ApiService(this.channel);

  Stream get realTimeData => channel.stream;
}
