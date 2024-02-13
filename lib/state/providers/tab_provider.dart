import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/state/notifiers/tab_state_notifier.dart';

final tabProvider = StateNotifierProvider<TabStateNotifier, int>((ref) => TabStateNotifier());
