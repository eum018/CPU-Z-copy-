import 'package:flutter/material.dart';


class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.deepPurpleAccent,
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(width: 16,),
        _left(),
        Spacer(),
        _right(),
    ],),);
  }


  Widget _left () {
    return Row(children: [
      Icon(Icons.image, color: Colors.white,),
      Text("CPU-Z", style: TextStyle(color: Colors.white, fontWeight: .w500, fontSize: 20),),
    ],);
  }

  Widget _right () {
    return Row(children: [
      Icon(Icons.image, color: Colors.white, ),
      IconButton(onPressed: () {}, icon: Icon(Icons.more_vert, color: Colors.white,)),
    ],);
  }

  @override
  Size get preferredSize => Size.fromHeight(184);
}
