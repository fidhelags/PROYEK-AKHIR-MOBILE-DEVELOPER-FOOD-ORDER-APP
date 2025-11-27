import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/auth_cubit.dart';
import 'cubit/cart_cubit.dart';
import 'cubit/food_cubit.dart';
import 'cubit/favorites_cubit.dart';

import 'pages/main_page.dart';
import 'pages/login_page.dart'; 
import 'pages/register_page.dart';    

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CartCubit()),
        BlocProvider(create: (_) => AuthCubit()),      
        BlocProvider(create: (_) => FoodCubit()),    
        BlocProvider(create: (_) => FavoritesCubit()), 
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: LoginPage(),

      routes: {
        '/main': (_) => MainPage(),
        '/login': (_) => LoginPage(),
        '/register': (_) => RegisterPage(),
      },
    );
  }
}
