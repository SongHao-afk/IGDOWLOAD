import 'dart:convert';

import 'package:flutter/widgets.dart';

import '../../../l10n/app_localizations.dart';

class DownloaderMessages {
  const DownloaderMessages._();

  static const String _prefix = '@@igdl:';

  static String encode(String key, [Map<String, Object?> args = const {}]) {
    final payload = <String, Object?>{
      'key': key,
      if (args.isNotEmpty) 'args': args,
    };

    return '$_prefix${jsonEncode(payload)}';
  }

  static _DecodedMessage? _decode(String value) {
    final clean = value.trim();
    if (!clean.startsWith(_prefix)) return null;

    try {
      final decoded = jsonDecode(clean.substring(_prefix.length));
      if (decoded is! Map) return null;

      final key = decoded['key']?.toString() ?? '';
      if (key.isEmpty) return null;

      final rawArgs = decoded['args'];
      final args = rawArgs is Map
          ? rawArgs.map((key, value) => MapEntry(key.toString(), value))
          : <String, Object?>{};

      return _DecodedMessage(key, args);
    } catch (_) {
      return null;
    }
  }

  static bool isLoginRequired(String value) {
    return _decode(value)?.key == 'loginRequired';
  }

  static bool isFollowRequired(String value) {
    return _decode(value)?.key == 'followRequired';
  }

  static bool isDownloadSuccess(String value) {
    final key = _decode(value)?.key;

    return key == 'savedStoryToAlbum' ||
        key == 'savedToAlbum' ||
        key == 'savedContentToAlbum';
  }

  static String resolve(BuildContext context, String value) {
    final decoded = _decode(value);
    if (decoded == null) return value;

    final l10n = AppLocalizations.of(context)!;
    final args = decoded.args;
    final count = _intArg(args, 'count');
    final storyCount = _intArg(args, 'storyCount');
    final postCount = _intArg(args, 'postCount');
    final title = _stringArg(args, 'title');
    final username = _stringArg(args, 'username');
    final albumName = _stringArg(args, 'albumName');
    final percent = _stringArg(args, 'percent');

    switch (decoded.key) {
      case 'loginRequired':
        return l10n.loginRequiredTitle;
      case 'followRequired':
        return l10n.followRequiredTitle;
      case 'profileSavedMissingUsername':
        return l10n.profileSavedMissingUsername;
      case 'openingProfile':
        return l10n.openingProfile;
      case 'openingUsername':
        return l10n.openingUsername(username);
      case 'foundStoryHighlightsAndPosts':
        return l10n.foundStoryHighlightsAndPosts(storyCount, postCount);
      case 'privateModeEnabled':
        return l10n.privateModeEnabled;
      case 'publicModeEnabled':
        return l10n.publicModeEnabled;
      case 'cannotConfirmInstagramLogin':
        return l10n.cannotConfirmInstagramLogin;
      case 'instagramConnected':
        return l10n.instagramConnected;
      case 'loggingOutInstagram':
        return l10n.loggingOutInstagram;
      case 'instagramLoggedOut':
        return l10n.instagramLoggedOut;
      case 'instagramLogoutCleanupFailed':
        return l10n.instagramLogoutCleanupFailed;
      case 'emptyInstagramLink':
        return l10n.emptyInstagramLink;
      case 'preparingContent':
        return l10n.preparingContent;
      case 'loadingContentWithAccount':
        return l10n.loadingContentWithAccount;
      case 'cannotFetchContent':
        return l10n.cannotFetchContent;
      case 'noDownloadableContentFound':
        return l10n.noDownloadableContentFound;
      case 'foundDownloadableContent':
        return l10n.foundDownloadableContent(count);
      case 'fetchContentFailedPublic':
        return l10n.fetchContentFailedPublic;
      case 'fetchContentFailedPrivate':
        return l10n.fetchContentFailedPrivate;
      case 'emptyProfileInput':
        return l10n.emptyProfileInput;
      case 'loadingStoryHighlights':
        return l10n.loadingStoryHighlights;
      case 'noCurrentStoryOrHighlight':
        return l10n.noCurrentStoryOrHighlight;
      case 'foundStoryHighlights':
        return l10n.foundStoryHighlights(count);
      case 'noStoryItems':
        return l10n.noStoryItems;
      case 'cannotOpenContent':
        return l10n.cannotOpenContent;
      case 'openingStoryGroup':
        return l10n.openingStoryGroup(title);
      case 'foundStoryGroupItems':
        return l10n.foundStoryGroupItems(count, title);
      case 'cannotOpenStoryHighlightLogin':
        return l10n.cannotOpenStoryHighlightLogin;
      case 'cannotOpenStoryHighlightPermission':
        return l10n.cannotOpenStoryHighlightPermission;
      case 'cannotDownloadContent':
        return l10n.cannotDownloadContent;
      case 'downloadingStory':
        return l10n.downloadingStory;
      case 'savedStoryToAlbum':
        return l10n.savedStoryToAlbum(albumName);
      case 'downloadStoryFailed':
        return l10n.downloadStoryFailed;
      case 'loadingReelsPublic':
        return l10n.loadingReelsPublic;
      case 'loadingReelsPrivate':
        return l10n.loadingReelsPrivate;
      case 'noReelsOrPermission':
        return l10n.noReelsOrPermission;
      case 'foundReels':
        return l10n.foundReels(count);
      case 'cannotLoadReelsPublic':
        return l10n.cannotLoadReelsPublic;
      case 'cannotLoadReelsPrivate':
        return l10n.cannotLoadReelsPrivate;
      case 'loadingPostsPublic':
        return l10n.loadingPostsPublic;
      case 'loadingPostsPrivate':
        return l10n.loadingPostsPrivate;
      case 'noPostsOrPermission':
        return l10n.noPostsOrPermission;
      case 'foundPosts':
        return l10n.foundPosts(count);
      case 'cannotLoadPostsPublic':
        return l10n.cannotLoadPostsPublic;
      case 'cannotLoadPostsPrivate':
        return l10n.cannotLoadPostsPrivate;
      case 'endOfContent':
        return l10n.endOfContent;
      case 'cannotLoadMoreContent':
        return l10n.cannotLoadMoreContent;
      case 'cannotLoadMoreProfile':
        return l10n.cannotLoadMoreProfile;
      case 'loadingMore':
        return l10n.loadingMore;
      case 'noMoreNewContent':
        return l10n.noMoreNewContent;
      case 'loadedMoreContent':
        return l10n.loadedMoreContent(count);
      case 'loadMoreFailed':
        return l10n.loadMoreFailed;
      case 'openingReel':
        return l10n.openingReel;
      case 'openingPost':
        return l10n.openingPost;
      case 'cannotShowPostContent':
        return l10n.cannotShowPostContent;
      case 'cannotOpenContentPermission':
        return l10n.cannotOpenContentPermission;
      case 'downloadingContent':
        return l10n.downloadingContent;
      case 'savedToAlbum':
        return l10n.savedToAlbum(albumName);
      case 'savedContentToAlbum':
        return l10n.savedContentToAlbum(albumName);
      case 'downloadContentErrorRetry':
        return l10n.downloadContentErrorRetry;
      case 'downloadHistoryCleared':
        return l10n.downloadHistoryCleared;
      case 'downloadHistoryItemsRemoved':
        return l10n.downloadHistoryItemsRemoved(count);
      case 'downloadConnectionSlow':
        return l10n.downloadConnectionSlow;
      case 'downloadNetworkUnavailable':
        return l10n.downloadNetworkUnavailable;
      case 'downloadCancelled':
        return l10n.downloadCancelled;
      case 'downloadGenericError':
        return l10n.downloadGenericError;
      case 'downloadProgress':
        return l10n.downloadProgress(percent);
    }

    return value;
  }

  static String? resolveNullable(BuildContext context, String? value) {
    if (value == null) return null;
    return resolve(context, value);
  }

  static int _intArg(Map<String, Object?> args, String key) {
    final value = args[key];
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static String _stringArg(Map<String, Object?> args, String key) {
    return args[key]?.toString() ?? '';
  }

  static String loginRequired() => encode('loginRequired');
  static String followRequired() => encode('followRequired');
  static String profileSavedMissingUsername() =>
      encode('profileSavedMissingUsername');
  static String openingProfile() => encode('openingProfile');
  static String openingUsername(String username) =>
      encode('openingUsername', {'username': username});
  static String foundStoryHighlightsAndPosts(int storyCount, int postCount) =>
      encode('foundStoryHighlightsAndPosts', {
        'storyCount': storyCount,
        'postCount': postCount,
      });
  static String privateModeEnabled() => encode('privateModeEnabled');
  static String publicModeEnabled() => encode('publicModeEnabled');
  static String cannotConfirmInstagramLogin() =>
      encode('cannotConfirmInstagramLogin');
  static String instagramConnected() => encode('instagramConnected');
  static String loggingOutInstagram() => encode('loggingOutInstagram');
  static String instagramLoggedOut() => encode('instagramLoggedOut');
  static String instagramLogoutCleanupFailed() =>
      encode('instagramLogoutCleanupFailed');
  static String emptyInstagramLink() => encode('emptyInstagramLink');
  static String preparingContent() => encode('preparingContent');
  static String loadingContentWithAccount() =>
      encode('loadingContentWithAccount');
  static String cannotFetchContent() => encode('cannotFetchContent');
  static String noDownloadableContentFound() =>
      encode('noDownloadableContentFound');
  static String foundDownloadableContent(int count) =>
      encode('foundDownloadableContent', {'count': count});
  static String fetchContentFailedPublic() =>
      encode('fetchContentFailedPublic');
  static String fetchContentFailedPrivate() =>
      encode('fetchContentFailedPrivate');
  static String emptyProfileInput() => encode('emptyProfileInput');
  static String loadingStoryHighlights() => encode('loadingStoryHighlights');
  static String noCurrentStoryOrHighlight() =>
      encode('noCurrentStoryOrHighlight');
  static String foundStoryHighlights(int count) =>
      encode('foundStoryHighlights', {'count': count});
  static String noStoryItems() => encode('noStoryItems');
  static String cannotOpenContent() => encode('cannotOpenContent');
  static String openingStoryGroup(String title) =>
      encode('openingStoryGroup', {'title': title});
  static String foundStoryGroupItems(int count, String title) =>
      encode('foundStoryGroupItems', {'count': count, 'title': title});
  static String cannotOpenStoryHighlightLogin() =>
      encode('cannotOpenStoryHighlightLogin');
  static String cannotOpenStoryHighlightPermission() =>
      encode('cannotOpenStoryHighlightPermission');
  static String cannotDownloadContent() => encode('cannotDownloadContent');
  static String downloadingStory() => encode('downloadingStory');
  static String savedStoryToAlbum(String albumName) =>
      encode('savedStoryToAlbum', {'albumName': albumName});
  static String downloadStoryFailed() => encode('downloadStoryFailed');
  static String loadingReelsPublic() => encode('loadingReelsPublic');
  static String loadingReelsPrivate() => encode('loadingReelsPrivate');
  static String noReelsOrPermission() => encode('noReelsOrPermission');
  static String foundReels(int count) => encode('foundReels', {'count': count});
  static String cannotLoadReelsPublic() => encode('cannotLoadReelsPublic');
  static String cannotLoadReelsPrivate() => encode('cannotLoadReelsPrivate');
  static String loadingPostsPublic() => encode('loadingPostsPublic');
  static String loadingPostsPrivate() => encode('loadingPostsPrivate');
  static String noPostsOrPermission() => encode('noPostsOrPermission');
  static String foundPosts(int count) => encode('foundPosts', {'count': count});
  static String cannotLoadPostsPublic() => encode('cannotLoadPostsPublic');
  static String cannotLoadPostsPrivate() => encode('cannotLoadPostsPrivate');
  static String endOfContent() => encode('endOfContent');
  static String cannotLoadMoreContent() => encode('cannotLoadMoreContent');
  static String cannotLoadMoreProfile() => encode('cannotLoadMoreProfile');
  static String loadingMore() => encode('loadingMore');
  static String noMoreNewContent() => encode('noMoreNewContent');
  static String loadedMoreContent(int count) =>
      encode('loadedMoreContent', {'count': count});
  static String loadMoreFailed() => encode('loadMoreFailed');
  static String openingReel() => encode('openingReel');
  static String openingPost() => encode('openingPost');
  static String cannotShowPostContent() => encode('cannotShowPostContent');
  static String cannotOpenContentPermission() =>
      encode('cannotOpenContentPermission');
  static String downloadingContent() => encode('downloadingContent');
  static String savedToAlbum(String albumName) =>
      encode('savedToAlbum', {'albumName': albumName});
  static String savedContentToAlbum(String albumName) =>
      encode('savedContentToAlbum', {'albumName': albumName});
  static String downloadContentErrorRetry() =>
      encode('downloadContentErrorRetry');
  static String downloadHistoryCleared() => encode('downloadHistoryCleared');
  static String downloadHistoryItemsRemoved(int count) =>
      encode('downloadHistoryItemsRemoved', {'count': count});
  static String downloadConnectionSlow() => encode('downloadConnectionSlow');
  static String downloadNetworkUnavailable() =>
      encode('downloadNetworkUnavailable');
  static String downloadCancelled() => encode('downloadCancelled');
  static String downloadGenericError() => encode('downloadGenericError');
  static String downloadProgress(String percent) =>
      encode('downloadProgress', {'percent': percent});
}

class _DecodedMessage {
  const _DecodedMessage(this.key, this.args);

  final String key;
  final Map<String, Object?> args;
}
