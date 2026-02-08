import 'package:cpu_z_copy/main.dart';
import 'package:cpu_z_copy/screen/layout/default_layout.dart';
import 'package:cpu_z_copy/screen/pages.dart';
import 'package:cpu_z_copy/widget/top_bar.dart';
import 'package:flutter/material.dart';

@immutable
class BaseScreen extends StatefulWidget {
  BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final List<String> keyList = [
    'SOC',
    'DEVICE',
    'SYSTEM',
    'BATTERY',
    'THERMAL',
    'SENSORS',
    'ABOUT',
  ];

  final List<Widget> pageList = [
    SOC(),
    Device(),
    System(),
    Battery(),
    Thermal(),
    Sensors(),
    About(),
  ];

  final ValueNotifier<int> _curIndex = ValueNotifier(0);

  final ScrollController _scrollController = ScrollController();

  final PageController _pageController = PageController();

  final GlobalKey _tapListKey = GlobalKey();

  final double _tapWidth = 84;

  Future<void> moveTo(int index) async {
    final halfWidth = MediaQuery.of(context).size.width / 2;
    final curWidth = _tapWidth * index;

    _curIndex.value = index;
    await _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );

    await _scrollController.animateTo(
      curWidth + curWidth > halfWidth ? halfWidth : 0,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  double? screen;

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.height;
    return DefaultLayout(
      appBar: TopBar(),
      child: Column(
        children: [
          _tapList(),

          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: moveTo,
              itemBuilder: (_, index) => pageList[index],
              itemCount: pageList.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tapList() {
    return SingleChildScrollView(
      scrollDirection: .horizontal,
      controller: _scrollController,
      child: ValueListenableBuilder(
        valueListenable: _curIndex,
        builder: (_, value, _) => Row(
          key: _tapListKey,
          children: List.generate(
            keyList.length,
            (index) => _tap(keyList[index], index),
          ),
        ),
      ),
    );
  }

  Widget _tap(String text, int index) {
    final bool isCurIndex = _curIndex.value == index;
    return InkWell(
      onTap: () async {
        await moveTo(index);
      },
      child: Container(
        width: _tapWidth,
        height: 48,
        alignment: .center,
        decoration: BoxDecoration(
          border: isCurIndex
              ? BoxBorder.fromLTRB(
                  bottom: BorderSide(color: Global.mainColor, width: 5),
                )
              : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isCurIndex ? Global.mainColor : Global.grey,
            fontWeight: .w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
