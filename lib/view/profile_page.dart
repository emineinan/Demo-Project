import 'package:demo_project/view/login_page.dart';
import 'package:demo_project/view/profile_page_detail.dart';
import 'package:demo_project/view/todo_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 231, 75, 35),
        title: Text("Profile"),
      ),
      body: Center(
        child: ProfilePageDetail(),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 231, 75, 35),
              ),
              accountName: Text("Emine İNAN"),
              accountEmail: Text("ei@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("images/user.jpg"),
              ),
            ),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ToDoPage()));
              },
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
              },
              leading: Icon(Icons.person),
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()));
              },
              leading: Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );
  }
}
