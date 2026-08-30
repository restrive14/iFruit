import 'package:flutter/material.dart';
import 'package:ifruit/core/db/db.dart';
import 'package:ifruit/core/model/pageParams.dart';
import 'package:ifruit/core/widgets/bottomBar.dart';
import 'package:ifruit/core/widgets/topStatusBar.dart';
import 'package:ifruit/features/club/model.dart';

class ClubPage extends StatefulWidget {
  const ClubPage({super.key});

  @override
  State<ClubPage> createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> {
  List<ClubDetail> _clubList = [];
  ClubDetail _clubInviteDetail = ClubDetail(
    id: '',
    avatar: '',
    content: '',
    name: '',
  );

  Future<void> _getClubList() async {
    try {
      final res = await DbHelper.instance.queryAll('club');
      final result = res
          .map(
            (item) => ClubDetail(
              id: item['id']?.toString() ?? '',
              avatar: item['avatar']?.toString() ?? '',
              name: item['name']?.toString() ?? '',
              content: item['content']?.toString() ?? '',
            ),
          )
          .toList();

      if (!mounted) return;

      setState(() {
        _clubList = result;
        if (_clubList.isNotEmpty) {
          _clubInviteDetail = _clubList.first;
        } else {
          _clubInviteDetail = ClubDetail(
            id: '',
            avatar: '',
            content: '',
            name: '',
          );
        }
      });
    } catch (e) {
      debugPrint('${e.toString()} club列表错误日志');
    }
  }

  void onTapDel() {
    setState(() {
      _clubInviteDetail = ClubDetail(id: '', avatar: '', content: '', name: '');
    });
  }

  void onTapPlus() {
    if (_clubInviteDetail.id.isEmpty) {
      return;
    }
    Navigator.pushNamed(
      context,
      '/clubDetail',
      arguments: PageParamsArgs(id: _clubInviteDetail.id),
    ).then((_) {
      _getClubList();
    });
  }

  @override
  void initState() {
    super.initState();
    _getClubList();
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    return Scaffold(
      appBar: TopStatusBar(title: '保镖事务所'),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(color: Colors.black),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 209, 133, 108),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _clubInviteDetail.name.isNotEmpty
                        ? _clubInviteDetail.name
                        : '无VIP邀请',
                    style: titleStyle,
                  ),
                  Text(
                    _clubInviteDetail.name.isNotEmpty ? '想让你成为一名副手' : '',
                    style: textStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(
        showDel: _clubInviteDetail.name.isNotEmpty,
        showPlus: _clubInviteDetail.name.isNotEmpty,
        onTapDel: onTapDel,
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
