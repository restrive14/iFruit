import 'package:flutter/material.dart';
import 'package:ifruit/core/db/db.dart';
import 'package:ifruit/core/widgets/bottomBar.dart';
import 'package:ifruit/core/widgets/topStatusBar.dart';
import 'package:ifruit/features/email/model.dart';

class EmailDetailPage extends StatefulWidget {
  final String emailId;

  const EmailDetailPage({super.key, required this.emailId});

  @override
  State<EmailDetailPage> createState() => _EmailDetailPageState();
}

class _EmailDetailPageState extends State<EmailDetailPage> {
  EmailItem? _emailData;
  final bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loademail();
  }

  Future<void> _loademail() async {
    try {
      final res = await DbHelper.instance.queryWhere(
        'email',
        where: 'id = ?',
        whereArgs: [widget.emailId],
      );

      if (res.isNotEmpty) {
        final item = res.first;
        _emailData = EmailItem(
          id: item['id']?.toString() ?? '',
          avatar: item['avatar']?.toString(),
          title: item['title']?.toString() ?? '',
          description: item['description']?.toString(),
          content: item['content']?.toString() ?? '',
          time: item['time']?.toString() ?? '',
        );

        await DbHelper.instance.markRead('email', widget.emailId);
      }

      setState(() {});
    } catch (e) {
      debugPrint('Error loading email data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyLarge;
    return Scaffold(
      appBar: TopStatusBar(title: '收件箱'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_emailData != null &&
                _emailData?.avatar != null &&
                _emailData?.avatar != '')
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Color.fromARGB(255, 191, 191, 191),
                    ),
                  ),
                ),
                child: Image.asset(_emailData?.avatar ?? '', fit: BoxFit.cover),
              ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('收件人：小哑巴', style: textStyle),
                  Text('发件人：${_emailData?.title ?? ''}', style: textStyle),
                  Text(_emailData?.content ?? '', style: textStyle),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(showDel: true, showPlus: false),
    );
  }
}
