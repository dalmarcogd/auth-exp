import 'package:flutter/material.dart';
import 'package:my_training_notes/constants/custom_colors.dart';
import 'package:my_training_notes/models/user.dart';
import 'package:my_training_notes/screens/account_screen.dart';
import 'package:my_training_notes/screens/sessinons_screen.dart';
import 'package:my_training_notes/screens/workouts_screen.dart';
import 'package:my_training_notes/widgets/app_bar_title.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _DashboardScreenScreenState createState() => _DashboardScreenScreenState();
}

class _DashboardScreenScreenState extends State<DashboardScreen> {
  static const List<Widget> _pages = <Widget>[
    WorkoutsScreen(),
    SessinonsScreen(),
    AccountScreen()
  ];

  late User _user;
  int _selectedIndex = 1;

  @override
  void initState() {
    _user = widget._user;

    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.firebaseNavy,
      appBar: getAppBar(),
      // body: getBody(),
      bottomNavigationBar: getBottomNavigationBar(),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: CustomColors.firebaseNavy,
      title: const AppBarTitle(),
    );
  }

  SafeArea getBody() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 20.0,
        ),
        child: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
      ),
    );
  }

  BottomNavigationBar getBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: CustomColors.firebaseNavy,
      fixedColor: CustomColors.firebaseOrange,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.work_outline),
          label: 'workouts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_box),
          label: 'session',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_box),
          label: 'account',
        ),
      ],
    );
  }
}
