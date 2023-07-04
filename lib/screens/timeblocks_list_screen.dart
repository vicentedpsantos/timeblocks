import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:timeblocks/screens/new_timeblock_screen.dart';
import 'package:timeblocks/providers/timeblocks_provider.dart';
import 'package:timeblocks/models/timeblock.dart';

class TimeblocksListScreen extends ConsumerStatefulWidget {
  const TimeblocksListScreen({super.key});

  @override
  ConsumerState<TimeblocksListScreen> createState() =>
      _TimeblocksListScreenState();
}

class _TimeblocksListScreenState extends ConsumerState<TimeblocksListScreen> {
  @override
  void initState() {
    ref.read(timeblocksProvider.notifier).fetchPersisted();

    super.initState();
  }

  void _pushNewTimeblockScreen(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => NewTimeblockScreen(),
      ),
    );
  }

  @override
  build(BuildContext context) {
    List<Timeblock> timeblocks = ref.watch(timeblocksProvider);

    Widget content = Text(
      'No timeblocks added yet...',
      style: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(color: Theme.of(context).colorScheme.onBackground),
    );

    if (timeblocks.isNotEmpty) {
      content = ListView.builder(
        itemCount: timeblocks.length,
        itemBuilder: (ctx, index) => Dismissible(
          onDimissed: () {
          },
          key: ValueKey(timeblocks[index].id),
          child: ListTile(
            title: Text(timeblocks[index].name),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My timeblocks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _pushNewTimeblockScreen(context);
            },
          ),
        ],
      ),
      body: Center(
        child: content,
      ),
    );
  }
}
