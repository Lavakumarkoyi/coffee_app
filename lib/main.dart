/// This is the main page I have created the home screen Widget here and called all other required widgets over here.

import 'package:coffee_app/core/network/dio_client.dart';
import 'package:coffee_app/features/card_swipe/data/repository/image_repository_impl.dart';
import 'package:coffee_app/features/card_swipe/data/source/images_data_source.dart';
import 'package:coffee_app/features/card_swipe/domain/usecase/images_usecase.dart';
import 'package:coffee_app/features/card_swipe/presentation/bloc/button/button_bloc.dart';
import 'package:coffee_app/features/card_swipe/presentation/bloc/coffee/coffee_bloc.dart';
import 'package:coffee_app/features/card_swipe/presentation/bloc/internet/internet_bloc.dart';
import 'package:coffee_app/features/card_swipe/presentation/pages/home.dart';
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
          // create: (context) => CoffeeBloc(
          //   internetBloc: BlocProvider.of<InternetBloc>(context),
          // ),
          create: (context) => CoffeeBloc(
              coffeeImages: ImagesUsecase(
                  CoffeeImageRepositoryImpl(imagesRemoteDataSource: ImagesRemoteDataSourceImpl(DioClient())))),
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
          '/': (context) => const HomePage(),
          '/wishlist': (context) => StaggeredGridView(),
        },
      ),
    );
  }
}
