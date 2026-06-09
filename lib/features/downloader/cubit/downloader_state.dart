import '../../../core/constants/app_constants.dart';
import '../models/ig_media_item.dart';

class DownloaderState {
  final String serverBaseUrl;
  final String status;
  final bool loading;
  final List<IgMediaItem> media;

  // Item nào đang tải, ví dụ media id 1, 2, 3
  final Set<int> downloadingIds;

  // Lỗi riêng từng item, tránh phun DioException global lên toàn màn
  final Map<int, String> downloadErrors;

  // Đang bấm "Tải tất cả"
  final bool downloadingAll;

  // Chế độ tải private/public
  final bool privateMode;

  // Cookie Instagram lấy từ WebView trên máy client
  final String? privateIgCookie;

  // Đang login/logout private mode
  final bool sessionBusy;

  const DownloaderState({
    required this.serverBaseUrl,
    required this.status,
    required this.loading,
    required this.media,
    required this.downloadingIds,
    required this.downloadErrors,
    required this.downloadingAll,
    required this.privateMode,
    required this.privateIgCookie,
    required this.sessionBusy,
  });

  factory DownloaderState.initial() {
    return const DownloaderState(
      serverBaseUrl: AppConstants.defaultServerBaseUrl,
      status: '',
      loading: false,
      media: [],
      downloadingIds: <int>{},
      downloadErrors: <int, String>{},
      downloadingAll: false,
      privateMode: false,
      privateIgCookie: null,
      sessionBusy: false,
    );
  }

  bool get isAnyDownloading => downloadingIds.isNotEmpty || downloadingAll;

  bool get hasPrivateCookie {
    return privateIgCookie != null && privateIgCookie!.trim().isNotEmpty;
  }

  String? get activeIgCookie {
    if (privateMode && hasPrivateCookie) {
      return privateIgCookie;
    }

    return null;
  }

  DownloaderState copyWith({
    String? serverBaseUrl,
    String? status,
    bool? loading,
    List<IgMediaItem>? media,
    Set<int>? downloadingIds,
    Map<int, String>? downloadErrors,
    bool? downloadingAll,
    bool? privateMode,
    String? privateIgCookie,
    bool clearPrivateIgCookie = false,
    bool? sessionBusy,
  }) {
    return DownloaderState(
      serverBaseUrl: serverBaseUrl ?? this.serverBaseUrl,
      status: status ?? this.status,
      loading: loading ?? this.loading,
      media: media ?? this.media,
      downloadingIds: downloadingIds ?? this.downloadingIds,
      downloadErrors: downloadErrors ?? this.downloadErrors,
      downloadingAll: downloadingAll ?? this.downloadingAll,
      privateMode: privateMode ?? this.privateMode,
      privateIgCookie: clearPrivateIgCookie
          ? null
          : privateIgCookie ?? this.privateIgCookie,
      sessionBusy: sessionBusy ?? this.sessionBusy,
    );
  }
}
