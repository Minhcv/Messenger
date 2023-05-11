import 'package:flutter/material.dart';
import 'package:messenger/pages/profile/profile_page.dart';
import 'package:messenger/pages/recent_conversations/recent_conversations_page.dart';
import 'package:messenger/pages/search/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late double _height;
  late double _width;

  late TabController _tabController;

  _HomePageState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        textTheme: const TextTheme(
          titleMedium: TextStyle(fontSize: 16),
        ),
        title: const Text("Chatify"),
        bottom: TabBar(
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
          labelColor: Colors.blue,
          controller: _tabController,
          tabs: [
            const Tab(
              icon: Icon(
                Icons.people_outline,
                size: 25,
              ),
            ),
            const Tab(
              icon: Icon(
                Icons.chat_bubble_outline,
                size: 25,
              ),
            ),
            const Tab(
              icon: Icon(
                Icons.person_outline,
                size: 25,
              ),
            ),
          ],
        ),
      ),
      body: _tabBarPages(),
    );
  }

  Widget _tabBarPages() {
    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        SearchPage(_height, _width),
        RecentConversationsPage(_height, _width),
        ProfilePage(_height, _width),
      ],
    );
  }
}
