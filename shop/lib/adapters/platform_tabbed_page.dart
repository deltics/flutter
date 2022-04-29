import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabDefinition {
  final Widget icon;
  final String title;
  final Widget content;
  final navigationKey = GlobalKey<NavigatorState>();

  TabDefinition({
    required this.icon,
    required this.title,
    required this.content,
  });
}

class PlatformTabbedPage extends StatefulWidget {
  final List<TabDefinition> tabs;
  final String title;
  final Widget? drawer;
  final Map<String, Widget Function(BuildContext)>? appRoutes;

  PlatformTabbedPage({
    Key? key,
    required this.tabs,
    required this.title,
    this.drawer,
    this.appRoutes,
  }) : super(key: key);

  @override
  State<PlatformTabbedPage> createState() => _PlatformTabbedPageState();
}

class _PlatformTabbedPageState extends State<PlatformTabbedPage> {
  int _activeTabIndex = 0;

  void _activateTab(int tabIndex) {
    setState(() => _activeTabIndex = tabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.tabs.length,
      child: Scaffold(
        bottomNavigationBar: Platform.isIOS
            ? BottomNavigationBar(
                backgroundColor: Theme.of(context).primaryColor,
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.white,
                currentIndex: _activeTabIndex,
                items: widget.tabs
                    .map(
                      (tab) => BottomNavigationBarItem(
                        label: tab.title,
                        icon: tab.icon,
                      ),
                    )
                    .toList(),
                onTap: _activateTab,
              )
            : null,
        appBar: AppBar(
          title: Text(widget.title),
          bottom: Platform.isAndroid
              ? TabBar(
                  tabs: widget.tabs
                      .map(
                        (tab) => Tab(
                          icon: tab.icon,
                          text: tab.title,
                        ),
                      )
                      .toList(),
                )
              : null,
        ),
        drawer: widget.drawer,
        body: Platform.isIOS
            ? widget.tabs[_activeTabIndex].content
            : TabBarView(
                children: widget.tabs
                    .map(
                      (tab) => tab.content,
                    )
                    .toList(),
              ),
      ),
    );
  }
}
