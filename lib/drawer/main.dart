import 'package:bodima/drawer/logout.dart';
import 'package:flutter/material.dart';

class DefaultSideDrawer extends StatelessWidget {
  DefaultSideDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              "Sidath Ranasinghe",
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor:
              Theme.of(context).platform == TargetPlatform.iOS
                  ? Colors.cyan
                  : Colors.white,
              child: Text(
                "S",
                style: TextStyle(fontSize: 40.0),
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: new AssetImage('assets/code3.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            accountEmail: null,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          /*ListTile(
            leading: Icon(Icons.assignment),
            title: Text('News'),
            //anik supervisersla gena minissu kyla thyenne monwd blna eka.
            //minissu daana posts balana eka.
            onTap: () {
              Navigator.pushNamed(context, '/newsFeedPage');
            },
          ),*/
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.error_outline),
            title: Text('About us'),
            onTap: () {
              Navigator.pushNamed(context, '/about_us');
            },
          ),
          LogoutListTile(),
        ],
      ),
    );
  }
}
