import 'package:cpu_z_copy/main.dart';
import 'package:flutter/material.dart';


class InfoItem extends StatelessWidget {
  final String title;
  final List<String> infos;

  const InfoItem({super.key, required this.title, required this.infos});

  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(border: Border.symmetric(horizontal: BorderSide(color: Global.lightGrey, width: 2))),
      child: Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(width: 16,),
        Expanded(flex: 4, child: Align(alignment: .topLeft, child: Text(title, style: TextStyle(),))),
        Expanded(flex: 6, child: Align(alignment: .topLeft, child: Column(children: List.generate(infos.length, (index) => Text(infos[index], style: TextStyle(color: Global.mainColor), softWrap: true,),),))),
            ],),
      ),);
  }
}



class SensorItem extends StatelessWidget {
  final String title;
  final String info;

  const SensorItem({super.key, required this.title, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(width: double.maxFinite,decoration: BoxDecoration(border: Border.symmetric(horizontal: BorderSide(color: Global.lightGrey, width: 2))),
      child: Padding(padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: TextStyle(),),
          Text(info, style: TextStyle(color: Global.mainColor)),
          ],),
      ),);
  }
}
