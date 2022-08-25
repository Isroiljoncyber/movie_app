import 'package:flutter/material.dart';
import 'package:movie_app/screen/popular_page.dart';
import 'package:movie_app/screen/upcoming_page.dart';

import 'now_playing_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final PageController _pageController = PageController(keepPage: true);
  int _page = 0;

  final List<Widget> _bottomNavPages = <Widget>[
    const NewPlayingPage(),
    const UpcomingPage(),
    const PopularPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Movies App'),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: navigationTapped,
        children: _bottomNavPages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.chair), label: "Now Playing"),
          BottomNavigationBarItem(
              icon: Icon(Icons.upcoming), label: "Upcoming"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Popular"),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    setState(() {
      _page = page;
    });
  }

// void _onItemTapped(int index) {
//   _pageController.jumpToPage(index);
//   setState(() {
//     _page = index;
//   });
// }

}

// [
// //Now Playing
// Offstage(
// offstage: _page != 0,
// child: TickerMode(
// enabled: _page == 0,
// child: FutureBuilder(
// future: getNowPlayingMovies(),
// builder:
// (BuildContext context, AsyncSnapshot<List> snapshot) {
// if (!snapshot.hasData) {
// return const Center(
// child: CircularProgressIndicator(),
// );
// }
// // Shows the real data with the data retrieved.
// List movies = snapshot.data;
// return CustomScrollView(
// primary: false,
// slivers: <Widget>[
// SliverPadding(
// padding: const EdgeInsets.all(10.0),
// sliver: SliverGrid.count(
// crossAxisSpacing: 10.0,
// mainAxisSpacing: 10.0,
// crossAxisCount: 2,
// children:
// createNowPlayingMovieCardItem(movies, context),
// ),
// ),
// ],
// );
// }),
// ),
// ),
// //Upcoming
// Offstage(
// offstage: _page != 1,
// child: TickerMode(
// enabled: _page == 1,
// child: FutureBuilder(
// future: getUpcomingMovies(),
// builder:
// (BuildContext context, AsyncSnapshot<List> snapshot) {
// if (!snapshot.hasData) {
// return const Center(
// child: CircularProgressIndicator(),
// );
// }
// // Shows the real data with the data retrieved.
// List movies = snapshot.data;
// return CustomScrollView(
// primary: false,
// slivers: <Widget>[
// SliverPadding(
// padding: const EdgeInsets.all(10.0),
// sliver: SliverGrid.count(
// crossAxisSpacing: 10.0,
// mainAxisSpacing: 10.0,
// crossAxisCount: 2,
// children:
// createUpcomingMovieCardItem(movies, context),
// ),
// ),
// ],
// );
// }),
// ),
// ),
// //Popular
// Offstage(
// offstage: _page != 2,
// child: TickerMode(
// enabled: _page == 2,
// child: FutureBuilder(
// future: getPopularMovies(),
// builder:
// (BuildContext context, AsyncSnapshot<List> snapshot) {
// if (!snapshot.hasData) {
// return const Center(
// child: CircularProgressIndicator(),
// );
// }
// // Shows the real data with the data retrieved.
// List movies = snapshot.data;
// return CustomScrollView(
// primary: false,
// slivers: <Widget>[
// SliverPadding(
// padding: const EdgeInsets.all(10.0),
// sliver: SliverGrid.count(
// crossAxisSpacing: 10.0,
// mainAxisSpacing: 10.0,
// crossAxisCount: 2,
// children:
// createPopularMovieCardItem(movies, context),
// ),
// ),
// ],
// );
// }),
// ),
// ),
// ],
