import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_app/state/image_upload/providers/image_upload_provider.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authSate = ref.watch(authStateProvider);
  final isUploadingImage = ref.watch(imageUploaderProvider);

  return authSate.isLoading || isUploadingImage;
});
