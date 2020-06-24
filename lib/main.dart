import 'package:flutter/material.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Rail example',
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;

  List<Widget> pages = [
    PageWidget(pageNumber: 1),
    PageWidget(pageNumber: 2),
    PageWidget(pageNumber: 3),
  ];

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(title: Text('NavigationRail Example'),),
      bottomNavigationBar: (deviceWidth < 700)
          ? BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border),
                  activeIcon: Icon(Icons.favorite),
                  title: Text('First'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark_border),
                  activeIcon: Icon(Icons.book),
                  title: Text('Second'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.star_border),
                  activeIcon: Icon(Icons.star),
                  title: Text('third'),
                ),
              ],
            )
          : null,
      body: (deviceWidth < 700)
          ? pages[_selectedIndex]
          : SafeArea(
              child: Row(
                children: <Widget>[
                  NavigationRail(
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: (int index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    labelType: NavigationRailLabelType.selected,
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(Icons.favorite_border),
                        selectedIcon: Icon(Icons.favorite),
                        label: Text('First'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.bookmark_border),
                        selectedIcon: Icon(Icons.book),
                        label: Text('Second'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.star_border),
                        selectedIcon: Icon(Icons.star),
                        label: Text('Third'),
                      ),
                    ],
                  ),
                  VerticalDivider(thickness: 1, width: 1),
                  // This is the main content.
                  Expanded(
                    child: pages[_selectedIndex],
                  ),
                ],
              ),
            ),
    );
  }
}

class PageWidget extends StatelessWidget {
  final int pageNumber;

  const PageWidget({Key key, this.pageNumber});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (ctx, index) => ListTile(
        title: Text('page $pageNumber item ${index + 1}'),
      ),
    );
  }
}
