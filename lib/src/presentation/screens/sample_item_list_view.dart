import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/src/app/theme/settings_view.dart';
import 'package:sample/src/data/models/user/user.dart';
import 'package:sample/src/data/repositories/user_repository.dart';
import 'package:sample/src/presentation/bloc/user_cubit.dart';

import 'sample_item_details_view.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatefulWidget {
  SampleItemListView({
    super.key,
  });

  static const routeName = '/';

  @override
  State<SampleItemListView> createState() => _SampleItemListViewState();
}

class _SampleItemListViewState extends State<SampleItemListView> {
  List<UserDto> userList = [];
  UserCubit scannerCubit = UserCubit(userRepository: UserRepositoryImpl());

  @override
  void didChangeDependencies() {
    scannerCubit.getUsers();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => scannerCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sample Items'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // Navigate to the settings page. If the user leaves and returns
                // to the app after it has been killed while running in the
                // background, the navigation stack is restored.
                Navigator.restorablePushNamed(context, SettingsView.routeName);
              },
            ),
          ],
        ),

        // To work with lists that may contain a large number of items, it’s best
        // to use the ListView.builder constructor.
        //
        // In contrast to the default ListView constructor, which requires
        // building all Widgets up front, the ListView.builder constructor lazily
        // builds Widgets as they’re scrolled into view.
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserSuccess) {
              userList = state.userList;
            }
            return ListView.builder(
              // Providing a restorationId allows the ListView to restore the
              // scroll position when a user leaves and returns to the app after it
              // has been killed while running in the background.
              restorationId: 'sampleItemListView',
              itemCount: userList.length,
              itemBuilder: (BuildContext context, int index) {
                final user = userList[index];

                return ListTile(
                    title: Text(' ${user.name}'),
                    leading: CircleAvatar(
                      // Display the Flutter Logo image asset.
                      foregroundImage: NetworkImage('${user.imageUrl}'),
                    ),
                    trailing: Text(' ${user.id}'),
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has been killed while running in the
                      // background, the navigation stack is restored.
                      Navigator.restorablePushNamed(
                        context,
                        SampleItemDetailsView.routeName,
                      );
                    });
              },
            );
          },
        ),
      ),
    );
  }
}
