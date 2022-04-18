import 'package:flutter/material.dart';

import '../adapters/platform_page.dart';

class FiltersPage extends StatelessWidget {
  static const route = '/filters';

  const FiltersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PlatformPage(
      title: 'Filters',
      content: Center(
        child: Text('Filters'),
      ),
    );
  }
}
