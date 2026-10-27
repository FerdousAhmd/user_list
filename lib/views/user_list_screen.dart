
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/user/user_bloc.dart';
import '../blocs/user/user_event.dart';
import '../blocs/user/user_state.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Directory'),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserInitial || state is UserLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is UserError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.message),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      context.read<UserBloc>().add(
                        const FetchUsers(),
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is UserLoaded) {
            final users = state.users;

            return RefreshIndicator(
              onRefresh: () async {
                context.read<UserBloc>().add(
                  const FetchUsers(),
                );
                await context.read<UserBloc>().stream.firstWhere(
                      (state) =>
                  state is UserLoaded || state is UserError,
                );
              },
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(user.picture),
                      ),
                      title: Text(user.name),
                      subtitle: Text(user.email),
                    ),
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
