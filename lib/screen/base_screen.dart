import 'package:cpu_z_copy/main.dart';
import 'package:cpu_z_copy/screen/layout/default_layout.dart';
import 'package:cpu_z_copy/screen/pages.dart';
import 'package:cpu_z_copy/widget/top_bar.dart';
import 'package:flutter/material.dart';

@immutable
class BaseScreen extends StatelessWidget {
  BaseScreen({super.key});

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
    SOC(key: Key('SOC'),),
    Device(key: Key('DEVICE'),),
    System(key: Key('SYSTEM')),
    Battery(key: Key('BATTERY')),
    Thermal(key: Key('THERMAL')),
    Sensors(key: Key('SENSORS')),
    About(key: Key('ABOUT')),
  ];


  final ValueNotifier<int> _curIndex = ValueNotifier(0);
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();
  final GlobalKey _tapListKey = GlobalKey();

  void moveTo(int value) { _curIndex.value = value;}

  double? screen;


  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.height;
    return DefaultLayout(appBar: TopBar(), child: Column(children: [

      tapList(),

      Expanded(
        child: PageView.builder(
          controller: _pageController,
          onPageChanged: moveTo,
          itemBuilder: (_, index) => pageList[index],
          itemCount: pageList.length,
        ),
      ),


    ],),
    );
  }


  Widget tapList () {
    return SingleChildScrollView(scrollDirection:.horizontal, controller: _scrollController,
        child: ValueListenableBuilder(valueListenable: _curIndex,
            builder: (_, value, _) => Row(key: _tapListKey, children: List.generate(keyList.length,
                      (index) => tap(keyList[index], index)),)
            ));
  }


  Widget tap (String text, int index) {
    final bool isCurIndex = _curIndex.value == index;
    return InkWell(
      onTap: () {moveTo(index);},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 11, vertical: 8),
        decoration: BoxDecoration(
          border: isCurIndex ? BoxBorder.fromLTRB(bottom: BorderSide(color: Global.mainColor, width: 5)) : null,
        ),
        child: Text(text, style: TextStyle(color: isCurIndex ? Global.mainColor : Global.grey, fontWeight: .w600, fontSize: 15),)),
    );
  }


}




