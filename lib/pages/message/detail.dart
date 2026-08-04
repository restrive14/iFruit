import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ifruit/models/message.dart';
import 'package:ifruit/widgets/bottomBar.dart';
import 'package:ifruit/widgets/topStatusBar.dart';

class MessageDetailPage extends StatefulWidget {
  final String messageId;

  const MessageDetailPage({super.key, required this.messageId});

  @override
  State<MessageDetailPage> createState() => _MessageDetailPageState();
}

class _MessageDetailPageState extends State<MessageDetailPage> {
  MessageItem? _messageData;
  final bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMessage();
  }

  Future<void> _loadMessage() async {
    try {
      final data = await rootBundle.loadString('assets/data/message.json');
      final List<dynamic> rawArray = json.decode(data);
      final List<MessageItem> result = rawArray
          .map((item) => MessageItem.fromJson(item))
          .toList();
      _messageData = result.firstWhere(
        (message) => message.id == widget.messageId,
      );
      setState(() {});
    } catch (e) {
      debugPrint('Error loading message data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopStatusBar(title: '短信'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(_messageData?.avatar ?? '', width: 70, height: 70),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _messageData?.title ?? '',
                    style: const TextStyle(fontSize: 22),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              _messageData?.content ?? '',
              style: const TextStyle(fontSize: 22, height: 1.5),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(showPlus: false),
    );
  }
}
