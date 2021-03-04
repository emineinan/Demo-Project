import 'package:demo_project/view/profile_page.dart';
import 'package:demo_project/view/todo_page.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  MenuPage({Key key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildDefaultTabController(),
    );
  }

  DefaultTabController buildDefaultTabController() {
    return DefaultTabController(
      length: 2,
      child: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
          ),
          Scaffold(
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: buildTabBar(),
            ),
            body: TabBarView(
              children: <Widget>[
                ProfilePage(),
                ToDoPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TabBar buildTabBar() {
    return TabBar(
      tabs: <Widget>[
        Tab(
          icon: Icon(Icons.person),
          text: "Profile",
        ),
        Tab(
          icon: Icon(Icons.home),
          text: "Home",
        ),
      ],
      labelColor: Color.fromARGB(255, 231, 75, 35),
      indicator: UnderlineTabIndicator(
        borderSide:
            BorderSide(color: Color.fromARGB(255, 231, 75, 35), width: 4.0),
        insets: EdgeInsets.only(bottom: 70),
      ),
      unselectedLabelColor: Colors.grey,
    );
  }
}
