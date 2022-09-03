import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/domain/cubits/popularMoviesCubit/popular_movies_cubit.dart';
import 'package:movie_app/domain/cubits/upcomingMoviesCubit/upcoming_movies_cubit.dart';
import 'package:movie_app/screen/popular_page.dart';
import 'package:movie_app/screen/upcoming_page.dart';

import '../domain/cubits/nowPlayingListCubit/now_playing_movies_cubit.dart';
import 'now_playing_page.dart';

enum SortType { popularity, voteCount, voteAverage }

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late final PageController _pageController = PageController(keepPage: true);
  int _page = 0;
  bool isSearch = false;
  late TextEditingController searchController = TextEditingController();
  final List<Widget> _bottomNavPages = <Widget>[
    const NewPlayingPage(),
    const UpcomingPage(),
    const PopularPage()
  ];

  late AnimationController animationController;
  late Animation<double> heightAnima;
  late Animation<double> fadedAnim;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    final curve =
        CurvedAnimation(parent: animationController, curve: Curves.ease);
    heightAnima = Tween<double>(begin: 0, end: 56).animate(curve);
    fadedAnim = Tween<double>(begin: 0, end: 1).animate(curve);

    searchController.addListener(() {
      if (_page == 0) {
        context
            .read<NowPlayingMoviesCubit>()
            .searchNowPlayingMovies(searchController.text.toString());
      } else if (_page == 1) {
        context
            .read<UpcomingMoviesCubit>()
            .searchUpcomingMovies(searchController.text.toString());
      } else {
        context
            .read<PopularMoviesCubit>()
            .searchPopularMovies(searchController.text.toString());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: heightAnima,
      builder: (context, child) {
        return Scaffold(
          appBar: _CustomAppBar(
            size: Size.fromHeight(heightAnima.value),
            child: AppBar(
              backgroundColor: Colors.blue.withOpacity(0.1),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(heightAnima.value),
                child: Visibility(
                  visible: isSearch,
                  child: FadeTransition(
                    opacity: fadedAnim,
                    child: Container(
                      height: 56,
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Flexible(
                            child: TextField(
                              cursorColor: Colors.white,
                              controller: searchController,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  gapPadding: 0,
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                hintText: "Search your movie",
                                hintStyle: const TextStyle(
                                    fontSize: 14, color: Colors.white),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  gapPadding: 0,
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  gapPadding: 0,
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: isSearch,
                            child: IconButton(
                              onPressed: () {
                                if (searchController.text.isNotEmpty) {
                                  searchController.text = "";
                                } else {
                                  animationController.reverse();
                                  Future.delayed(
                                    const Duration(milliseconds: 150),
                                    () => setState(
                                      () {
                                        isSearch = !isSearch;
                                      },
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(
                                Icons.close_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              centerTitle: true,
              title: const Text("Movie App"),
              actions: [
                PopupMenuButton<SortType>(
                  onSelected: (SortType sortType) {
                    if (_page == 0) {
                      context
                          .read<NowPlayingMoviesCubit>()
                          .sortNowPlayingMovies(sortType);
                    } else if (_page == 1) {
                      context
                          .read<UpcomingMoviesCubit>()
                          .sortUpcomingMovies(sortType);
                    } else {
                      context
                          .read<PopularMoviesCubit>()
                          .sortPopularMovies(sortType);
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<SortType>>[
                    const PopupMenuItem<SortType>(
                      value: SortType.popularity,
                      child: Text('By popularity'),
                    ),
                    const PopupMenuItem<SortType>(
                      value: SortType.voteAverage,
                      child: Text('By average vote'),
                    ),
                    const PopupMenuItem<SortType>(
                      value: SortType.voteCount,
                      child: Text('By vote count'),
                    ),
                  ],
                  icon: const Icon(Icons.sort),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    onPressed: () {
                      if (isSearch) {
                        animationController.reverse();
                        animationController.reverse();
                        Future.delayed(
                          const Duration(milliseconds: 150),
                          () => setState(
                            () {
                              isSearch = !isSearch;
                            },
                          ),
                        );
                      } else {
                        animationController.forward();
                        Future.delayed(
                          const Duration(milliseconds: 850),
                          () => setState(
                            () {
                              isSearch = !isSearch;
                            },
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.search),
                  ),
                ),
              ],
            ),
          ),
          body: PageView(
            controller: _pageController,
            onPageChanged: navigationTapped,
            children: _bottomNavPages,
          ),
          bottomNavigationBar: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 60),
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.chair), label: "Now Playing"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.upcoming), label: "Upcoming"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: "Popular"),
                ],
                onTap: navigationTapped,
                currentIndex: _page,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    animationController.dispose();
    super.dispose();
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
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  _CustomAppBar({required this.child, required this.size});

  Widget child;
  Size size;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 100),
        child: child,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56+size.height);
}
