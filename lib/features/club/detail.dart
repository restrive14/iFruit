import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ifruit/core/db/db.dart';
import 'package:ifruit/core/widgets/bottomBar.dart';
import 'package:ifruit/core/widgets/topStatusBar.dart';
import 'package:ifruit/features/club/model.dart';

class ClubDetailPage extends StatefulWidget {
  final String clubId;
  const ClubDetailPage({super.key, required this.clubId});

  @override
  State<ClubDetailPage> createState() => _ClubDetailPageState();
}

class _ClubDetailPageState extends State<ClubDetailPage> {
  ClubDetail? _clubInviteDetail;

  Future<void> _initData() async {
    try {
      final res = await DbHelper.instance.queryWhere(
        'club',
        where: 'id = ?',
        whereArgs: [widget.clubId],
      );

      if (!mounted || res.isEmpty) return;

      final item = res.first;
      _clubInviteDetail = ClubDetail(
        id: item['id']?.toString() ?? widget.clubId,
        avatar: item['avatar']?.toString() ?? '',
        name: item['name']?.toString() ?? '',
        content: item['content']?.toString() ?? '',
      );

      await DbHelper.instance.markRead('club', widget.clubId);
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      debugPrint('${e.toString()} club详情错误日志');
    }
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _onTapDel() async {
    try {
      await DbHelper.instance.delete(
        'club',
        where: 'id = ?',
        whereArgs: [widget.clubId],
      );
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      debugPrint('delete club detail error: $e');
    }
  }

  void onTapPlus() {
    Fluttertoast.showToast(msg: '已接受邀请');
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyle =
        Theme.of(context).textTheme.bodyLarge ??
        const TextStyle(fontSize: 16, height: 1.5, color: Colors.white);

    if (_clubInviteDetail == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: TopStatusBar(title: '邀请'),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(color: Colors.black),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    _clubInviteDetail!.avatar,
                    width: 70,
                    height: 70,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.person,
                        size: 70,
                        color: Colors.white,
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _clubInviteDetail!.name,
                      style: textStyle.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                _clubInviteDetail!.content,
                style: textStyle.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(
        showDel: true,
        onTapDel: _onTapDel,
        centerIcon: const Icon(
          Icons.check_rounded,
          color: Colors.green,
          size: 50,
        ),
        onTapPlus: onTapPlus,
      ),
    );
  }
}
