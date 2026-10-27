
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/user/user_bloc.dart';
import 'blocs/user/user_event.dart';
import 'repositories/user_repository.dart';
import 'services/api_service.dart';
import 'views/user_list_screen.dart';

void main() {
  final apiService = ApiService();
  final userRepository = UserRepository(apiService);

  runApp(
    MyApp(userRepository: userRepository),
  );
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  const MyApp({
    super.key,
    required this.userRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Directory',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => UserBloc(userRepository)
          ..add(const FetchUsers()),
        child: const UserListScreen(),
      ),
    );
  }
}
