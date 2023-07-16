import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipepicker/contanst.dart';
import 'package:recipepicker/screens/favorite.dart';
import 'package:recipepicker/screens/search.dart';
import 'package:recipepicker/state/app_state.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  AppBar customAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        appName,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, _) {
        return Scaffold(
          appBar: customAppBar(context),
          body: IndexedStack(
            index: state.selectedBottomNavbarIndex,
            children: const [
              Search(),
              Favorite(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (val) => state.updateSelectedNavbarIndex(val),
            currentIndex: state.selectedBottomNavbarIndex,
            items: const [
              BottomNavigationBarItem(
                label: "Search",
                icon: Icon(Icons.search),
              ),
              BottomNavigationBarItem(
                label: "Favorite",
                icon: Icon(Icons.favorite),
              ),
            ],
          ),
        );
      },
    );
  }
}
