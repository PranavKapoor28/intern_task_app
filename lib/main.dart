import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:page_view_indicators/page_view_indicators.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PageViewIndicators Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => HomePage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final _items = [
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.pink,
    Colors.red,
    Colors.amber,
  ];
  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CirclePageIndicator Demo'),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        _buildCircleIndicator3(),
        SizedBox(height: 30),
        _buildPageView(),
        Expanded(
          child: ListView(
            children: <Widget>[]
                .map((item) => Padding(
              child: item,
              padding: EdgeInsets.all(8.0),
            ))
                .toList(),
          ),
        ),
      ],
    );
  }

  _buildPageView() {
    return Container(
      height: 300,
      child: PageView.builder(
          itemCount: _items.length,
          controller: _pageController,
          itemBuilder: (BuildContext context, int index) {
            SizedBox(height: 110);
            return Column(
              children: <Widget>[
                Text(
                  'Page ${index + 1}',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                ),
                SizedBox(
                  height: 110,
                ),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: RaisedButton(
                      onPressed: () {
                        _pageController.jumpToPage(index + 1);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 1.0,
                      color: Colors.orange,
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(height: 1),
                          SizedBox(width: 10),
                          Text("Next"),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          onPageChanged: (int index) {
            _currentPageNotifier.value = index;
          }),
    );
  }

  _buildCircleIndicator3() {
    return Container(
      padding: const EdgeInsets.all(106.0),
      child: StepPageIndicator(
        itemCount: 6,
        currentPageNotifier: _currentPageNotifier,
        size: 20,
        onPageSelected: (int index) {
          if (_currentPageNotifier.value > index)
            _pageController.jumpToPage(index);
        },
      ),
    );
  }
}
