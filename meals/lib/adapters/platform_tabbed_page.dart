import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app.dart';
import '../widgets/drawer.dart';

class TabDefinition {
  final Icon icon;
  final String title;
  final Widget content;
  final navigationKey = GlobalKey<NavigatorState>();

  TabDefinition({
    required this.icon,
    required this.title,
    required this.content,
  });
}

class PlatformTabbedPage extends StatelessWidget {
  final List<TabDefinition> tabs;
  final String title;

  const PlatformTabbedPage({
    Key? key,
    required this.tabs,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text(title),
            ),
            child: SafeArea(
              child: CupertinoTabScaffold(
                  tabBar: CupertinoTabBar(
                    items: tabs
                        .map((tab) => BottomNavigationBarItem(
                              icon: tab.icon,
                              label: tab.title,
                            ))
                        .toList(),
                  ),
                  tabBuilder: (context, index) {
                    final tab = tabs[index];

                    return CupertinoTabView(
                      navigatorKey: tab.navigationKey,
                      builder: (_) => tab.content,
                      routes: routes,
                    );
                  }),
            ))
        : DefaultTabController(
            length: tabs.length,
            child: Scaffold(
              appBar: AppBar(
                title: Text(title),
                bottom: TabBar(
                  tabs: tabs
                      .map(
                        (tab) => Tab(
                          icon: tab.icon,
                          text: tab.title,
                        ),
                      )
                      .toList(),
                ),
              ),
              drawer: const AppDrawer(),
              body: TabBarView(
                children: tabs
                    .map(
                      (tab) => tab.content,
                    )
                    .toList(),
              ),
            ),
          );
  }
}
