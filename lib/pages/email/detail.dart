import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ifruit/models/email.dart';
import 'package:ifruit/widgets/bottomBar.dart';
import 'package:ifruit/widgets/topStatusBar.dart';

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
      final data = await rootBundle.loadString('assets/data/email.json');
      final List<dynamic> rawArray = json.decode(data);
      final List<EmailItem> result = rawArray
          .map((item) => EmailItem.fromJson(item))
          .toList();
      _emailData = result.firstWhere((email) => email.id == widget.emailId);
      setState(() {});
    } catch (e) {
      debugPrint('Error loading email data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    '收件人：小哑巴',
                    style: const TextStyle(fontSize: 22, height: 1.5),
                  ),
                  Text(
                    '发件人：${_emailData?.title ?? ''}',
                    style: const TextStyle(fontSize: 22, height: 1.5),
                  ),
                  Text(
                    _emailData?.content ?? '',
                    style: const TextStyle(fontSize: 22, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(showPlus: false),
    );
  }
}
