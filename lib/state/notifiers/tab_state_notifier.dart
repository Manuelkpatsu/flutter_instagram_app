import 'package:hooks_riverpod/hooks_riverpod.dart';

class TabStateNotifier extends StateNotifier<int> {
  TabStateNotifier() : super(0);

  void updateTab(int index) => state = index;
}
