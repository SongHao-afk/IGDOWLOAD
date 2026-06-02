import '../../../core/constants/app_constants.dart';
import '../models/ig_media_item.dart';

class DownloaderState {
  final String serverBaseUrl;
  final String status;
  final bool loading;
  final List<IgMediaItem> media;

  const DownloaderState({
    required this.serverBaseUrl,
    required this.status,
    required this.loading,
    required this.media,
  });

  factory DownloaderState.initial() {
    return const DownloaderState(
      serverBaseUrl: AppConstants.defaultServerBaseUrl,
      status: '',
      loading: false,
      media: [],
    );
  }

  DownloaderState copyWith({
    String? serverBaseUrl,
    String? status,
    bool? loading,
    List<IgMediaItem>? media,
  }) {
    return DownloaderState(
      serverBaseUrl: serverBaseUrl ?? this.serverBaseUrl,
      status: status ?? this.status,
      loading: loading ?? this.loading,
      media: media ?? this.media,
    );
  }
}
