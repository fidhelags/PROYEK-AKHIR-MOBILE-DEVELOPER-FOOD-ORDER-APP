import 'package:flutter/material.dart';

// TODO: Uncomment import berikut setelah install package yang diperlukan
// import 'package:flutter_bloc/flutter_bloc.dart';  // Install di Pekan 3
// import 'package:hive_flutter/hive_flutter.dart';  // Install di Pekan 5

// TODO: Import cubit dan service yang sudah dibuat
// import 'cubit/auth_cubit.dart';
// import 'cubit/cart_cubit.dart';
// import 'cubit/checkout_cubit.dart';
// import 'cubit/order_cubit.dart';
// import 'services/storage_service.dart';
// import 'pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: Uncomment setelah install hive_flutter (Pekan 5)
  // await Hive.initFlutter();

  // TODO: Uncomment setelah membuat StorageService
  // await StorageService.init();

  runApp(const AlFoodApp());
}

class AlFoodApp extends StatelessWidget {
  const AlFoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Uncomment setelah install flutter_bloc (Pekan 3)
    // return MultiBlocProvider(
    //   providers: [
        // TODO: Uncomment setelah membuat semua Cubit
        // BlocProvider(create: (context) => AuthCubit()),
        // BlocProvider(create: (context) => CartCubit()),
        // BlocProvider(create: (context) => CheckoutCubit()),
        // BlocProvider(create: (context) => OrderCubit()),
    //   ],
    //   child: MaterialApp(
    //     title: 'AlFood',
    //     theme: ThemeData(
    //       colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
    //       useMaterial3: true,
    //     ),
        // TODO: Uncomment setelah membuat SplashPage
        // home: const SplashPage(),
    //     home: const Scaffold(
    //       body: Center(
    //         child: Text('AlFood App - Mulai dari INSTRUKSI.md'),
    //       ),
    //     ),
    //     debugShowCheckedModeBanner: false,
    //   ),
    // );

    // Versi minimal tanpa package tambahan (untuk Pekan 1-2)
    return MaterialApp(
      title: 'AlFood',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      // TODO: Uncomment setelah membuat SplashPage
      // home: const SplashPage(),
      home: const Scaffold(
        body: Center(child: Text('AlFood App - Mulai dari INSTRUKSI.md')),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
