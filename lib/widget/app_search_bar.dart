import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class AppSearchBar extends StatelessWidget {
  AppSearchBar({Key? key, required this.hint, required this.onQueryChanged})
      : super(key: key);

  String hint;
  Function(String)? onQueryChanged;

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      child: FloatingSearchBar(
        hint: hint,
        backdropColor: Colors.white10,
        backgroundColor: Colors.grey.shade100,
        closeOnBackdropTap: true,
        elevation: 2,
        scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
        transitionDuration: const Duration(milliseconds: 300),
        transitionCurve: Curves.easeInOut,
        borderRadius: BorderRadius.circular(15),
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        width: isPortrait ? 600 : 500,
        onQueryChanged: onQueryChanged,
        transition: CircularFloatingSearchBarTransition(),
        builder: (context, transition) {
          return const SizedBox();
        },
      ),
    );
  }
}