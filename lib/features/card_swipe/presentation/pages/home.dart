import 'package:coffee_app/features/card_swipe/presentation/bloc/coffee/coffee_bloc.dart';
import 'package:coffee_app/features/card_swipe/presentation/bloc/internet/internet_bloc.dart';
import 'package:coffee_app/features/card_swipe/presentation/widgets/appbar.dart';
import 'package:coffee_app/features/card_swipe/presentation/widgets/cancel_button.dart';
import 'package:coffee_app/features/card_swipe/presentation/widgets/card_swiper.dart';
import 'package:coffee_app/features/card_swipe/presentation/widgets/heart_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
