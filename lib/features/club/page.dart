import 'package:flutter/material.dart';
import 'package:ifruit/core/db/db.dart';
import 'package:ifruit/core/model/pageParams.dart';
import 'package:ifruit/core/utils/audioplay.dart';
import 'package:ifruit/core/widgets/bottomBar.dart';
import 'package:ifruit/core/widgets/topStatusBar.dart';
import 'package:ifruit/features/club/model.dart';

class ClubPage extends StatefulWidget {
  const ClubPage({super.key});

  @override
  State<ClubPage> createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> {
  // 选中索引
  int _selectedIndex = 0;
  List<ClubDetail> _clubList = [];

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
          if (_selectedIndex >= _clubList.length) {
            _selectedIndex = _clubList.length - 1;
          }
        } else {
          _selectedIndex = 0;
        }
      });
    } catch (e) {
      debugPrint('${e.toString()} club列表错误日志');
    }
  }

  Future<void> onTapDel() async {
    if (_clubList.isEmpty || _selectedIndex >= _clubList.length) {
      return;
    }

    final selectedClub = _clubList[_selectedIndex];

    await DbHelper.instance.delete(
      'club',
      where: 'id = ?',
      whereArgs: [selectedClub.id],
    );

    if (!mounted) return;
    _getClubList();
  }

  void onTapPlus() {
    if (_clubList.isEmpty || _selectedIndex >= _clubList.length) {
      return;
    }

    final selectedClubId = _clubList[_selectedIndex].id;
    if (selectedClubId.isEmpty) {
      return;
    }

    Navigator.pushNamed(
      context,
      '/clubDetail',
      arguments: PageParamsArgs(id: selectedClubId),
    ).then((_) {
      _getClubList();
    });
  }

  void _onTapSelectItem(index) {
    AudioUtil().play(AudioSound.click);
    setState(() {
      _selectedIndex = index;
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
    final themeColor = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: TopStatusBar(title: '保镖事务所'),
      backgroundColor: Colors.black,
      body: _clubList.isNotEmpty
          ? ListView.builder(
              itemCount: _clubList.length,
              padding: EdgeInsets.symmetric(horizontal: 10),
              itemBuilder: (context, index) {
                final clubItem = _clubList[index];
                final isSelected = index == _selectedIndex;
                return GestureDetector(
                  onTap: () => _onTapSelectItem(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 20,
                    ),
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? themeColor
                          : const Color.fromARGB(255, 209, 133, 108),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          clubItem.name.isNotEmpty ? clubItem.name : '无VIP邀请',
                          style: titleStyle,
                        ),
                        Text(
                          clubItem.name.isNotEmpty ? '想让你成为一名副手' : '',
                          style: textStyle,
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 209, 133, 108),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('无VIP邀请', style: titleStyle),
                  Text('', style: textStyle),
                ],
              ),
            ),

      bottomNavigationBar: BottomBar(
        showDel: _clubList.isNotEmpty && _selectedIndex < _clubList.length,
        showPlus: _clubList.isNotEmpty && _selectedIndex < _clubList.length,
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
