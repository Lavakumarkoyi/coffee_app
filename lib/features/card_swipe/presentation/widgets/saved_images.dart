import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_app/features/card_swipe/presentation/bloc/coffee/coffee_bloc.dart';
import 'package:coffee_app/features/card_swipe/presentation/pages/home.dart';
import 'package:coffee_app/features/card_swipe/presentation/widgets/appbar.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StaggeredGridView extends StatefulWidget {
  @override
  State<StaggeredGridView> createState() => _StaggeredGridViewState();
}

class _StaggeredGridViewState extends State<StaggeredGridView> {
  void initState() {
    // BlocProvider.of<CoffeeBloc>(context, listen: false);
    BlocProvider.of<CoffeeBloc>(context).add(FetchAllCachedImagesEvent());
    BlocProvider.of<CoffeeBloc>(context).add((FetchCachedImageCountEvent()));
  }

  final List<String> imageUrls = [
    "lib/Assets/images/arthur.png",
    "lib/Assets/images/cherbas.png",
    "lib/Assets/images/klueg.png",
    "lib/Assets/images/jhon.png",
    "lib/Assets/images/lucy.png"
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    int getCrossAxisCount() {
      if (screenWidth < 600) {
        return 2;
      } else {
        return 4;
      }
    }

    return BlocListener<CoffeeBloc, CoffeeState>(
      listenWhen: (previous, current) => current is NavigateToHomePageState,
      listener: (context, state) {
        // print("black screen");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      },
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Staggered Image Grid'),
        // ),
        appBar: Appbar(
          onHomeTap: () {
            BlocProvider.of<CoffeeBloc>(context).add(NavigateToHomePageEvent());
            Navigator.pop(context, (route) => route.isFirst);
          },
        ),
        body: BlocBuilder<CoffeeBloc, CoffeeState>(
          buildWhen: (previous, current) {
            return current is FetchImagesFromCache;
          },
          builder: (context, state) {
            if (state is FetchImagesFromCache) {
              List<String> reversedImages = state.cachedImages.reversed.toList();
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: MasonryGridView.builder(
                  // crossAxisCount: getCrossAxisCount(),
                  gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: getCrossAxisCount()),
                  itemCount: reversedImages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: reversedImages[index],
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          )),
                    );
                  },
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
