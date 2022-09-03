import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class FrostedAppBar extends StatelessWidget {
  final String? title;
  final List<Widget>? actions;
  final bool? showLeading;

  const FrostedAppBar(
      {Key? key, this.title, this.actions, this.showLeading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: showLeading!,
      backgroundColor: Colors.blue.withOpacity(0.2),
      pinned: true,
      expandedHeight: 120,
      excludeHeaderSemantics: false,
      floating: false,
      centerTitle: true,
      surfaceTintColor: Colors.red,
      // snap: false,
      actions: actions ?? [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      flexibleSpace: ClipRect(
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
          child: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.all(8.0),
            title: Text(
              title!,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class BlurPage extends StatelessWidget {
  const BlurPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const FrostedAppBar(title: 'Watch Now'),
          SliverList(
            delegate: SliverChildListDelegate(
              List.generate(
                20,
                (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.primaries[
                            Random().nextInt(Colors.primaries.length)],
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    child: Center(
                      child: Text(
                        '$index',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            ?.copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
