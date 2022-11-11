// ignore_for_file: file_names

import 'package:flutter/material.dart';

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<StatefulWidget> createState()=> _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState  extends State<BottomNavigationBarExample>{
  int _currentIndex=0;
  @override
  Widget build(BuildContext context){
    final kTabItems=<Widget>[
      const Center(child: Icon(Icons.list, size:64.0, color: Colors.grey,),),
      const Center(child: Icon(Icons.add, size:64.0, color: Colors.blue,),),
      const Center(child: Icon(Icons.search, size:64.0, color: Colors.blue,),),
    ];
    final kBottomBarItems=<BottomNavigationBarItem>[
      const BottomNavigationBarItem(icon:Icon(Icons.list),label: 'List'),
      const BottomNavigationBarItem(icon:Icon(Icons.add),label: 'Add'),
      const BottomNavigationBarItem(icon:Icon(Icons.search),label: 'Search'),
    ];
    assert(kTabItems.length==kBottomBarItems.length);
    final bottomNavBar=BottomNavigationBar(
      items: kBottomBarItems,
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int value) {
        setState(() {
          _currentIndex=value;
        });
      },);
    return Scaffold(
      body: kTabItems[_currentIndex],
      bottomNavigationBar: bottomNavBar,
    );
  }
}