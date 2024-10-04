/// This is the main page I have created the home screen Widget here and called all other required widgets over here.

import 'package:coffee_app/features/card_swipe/presentation/bloc/button/button_bloc.dart';
import 'package:coffee_app/features/card_swipe/presentation/bloc/coffee/coffee_bloc.dart';
import 'package:coffee_app/features/card_swipe/presentation/bloc/internet/internet_bloc.dart';
import 'package:coffee_app/features/card_swipe/presentation/widgets/appbar.dart';
import 'package:coffee_app/features/card_swipe/presentation/widgets/cancel_button.dart';
import 'package:coffee_app/features/card_swipe/presentation/widgets/favorite_icon.dart';
import 'package:coffee_app/features/card_swipe/presentation/widgets/heart_button.dart';
import 'package:coffee_app/features/card_swipe/presentation/widgets/saved_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/card_swipe/presentation/widgets/card_swiper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InternetBloc()
            ..add(CheckConnectivity())
            ..startMonitoring(),
        ),
        BlocProvider(
          create: (context) => CoffeeBloc(
            internetBloc: BlocProvider.of<InternetBloc>(context),
          ),
        ),
        BlocProvider(
          create: (context) => ButtonBloc(),
        ),
        BlocProvider(
          create: (context) => HeartButtonBloc(),
        ),
        BlocProvider(
          create: (context) => CancelButtonBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // initialRoute: '/',
        routes: {
          '/': (context) => MainScreen(),
          '/wishlist': (context) => StaggeredGridView(),
        },
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late InternetBloc internetBloc;
  @override
  void initState() {
    internetBloc = BlocProvider.of<InternetBloc>(context);
    final coffeeBloc = BlocProvider.of<CoffeeBloc>(context);

    internetBloc.startMonitoring();
    internetBloc.add(CheckConnectivity());

    coffeeBloc.add((CoffeeImagesIntialEvent()));
    coffeeBloc.add((FetchCachedImageCountEvent()));

    super.initState();
  }

  @override
  void dispose() {
    internetBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        onHomeTap: () {},
      ),
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              // flex: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: BlocListener<InternetBloc, InternetState>(
                  listener: (context, state) {
                    if (state is InternetStatus && state.status == ConnectivityStatus.disconnected) {
                    } else if (state is InternetStatus && state.status == ConnectivityStatus.connected) {}
                  },
                  child: BlocBuilder<InternetBloc, InternetState>(
                    builder: (context, state) {
                      if (state is InternetStatus && state.status == ConnectivityStatus.disconnected) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is InternetStatus && state.status == ConnectivityStatus.connected) {
                        final coffeeBloc = BlocProvider.of<CoffeeBloc>(context);
                        coffeeBloc.add(CoffeeImagesIntialEvent());

                        return CoffeeSwiper();
                      } else {
                        return Center(child: Text("Checking connectivity..."));
                      }
                    },
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CancelButton(),
                    HeartButton(),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
