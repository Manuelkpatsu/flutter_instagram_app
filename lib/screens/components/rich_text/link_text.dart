import 'package:flutter/foundation.dart';

import 'base_text.dart';

@immutable
class LinkText extends BaseText {
  final VoidCallback onTap;

  const LinkText({required super.text, required this.onTap, super.style});
}
