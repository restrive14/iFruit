import 'package:flutter/material.dart';
import 'package:ifruit/core/db/db.dart';
import 'package:ifruit/core/widgets/bottomBar.dart';
import 'package:ifruit/core/widgets/topStatusBar.dart';
import 'package:ifruit/features/message/model.dart';

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
      final res = await DbHelper.instance.queryWhere(
        'message',
        where: 'id = ?',
        whereArgs: [widget.messageId],
      );

      if (res.isNotEmpty) {
        final item = res.first;
        _messageData = MessageItem(
          id: item['id']?.toString() ?? '',
          avatar: item['avatar']?.toString() ?? '',
          title: item['title']?.toString() ?? '',
          content: item['content']?.toString() ?? '',
          time: item['time']?.toString() ?? '',
        );

        await DbHelper.instance.markRead('message', widget.messageId);
      }

      setState(() {});
    } catch (e) {
      debugPrint('Error loading message data: $e');
    }
  }

  Future<void> _onTapDel() async {
    try {
      await DbHelper.instance.delete(
        'message',
        where: 'id = ?',
        whereArgs: [widget.messageId],
      );
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      debugPrint('delete message detail error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyLarge;
    return Scaffold(
      appBar: TopStatusBar(title: '短信'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    _messageData?.avatar ?? 'assets/icons/avatar/weizhi.webp',
                    width: 70,
                    height: 70,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(_messageData?.title ?? '', style: textStyle),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(_messageData?.content ?? '', style: textStyle),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(
        showDel: true,
        onTapDel: _onTapDel,
        centerIcon: const Icon(Icons.phone, color: Colors.green, size: 50),
      ),
    );
  }
}
