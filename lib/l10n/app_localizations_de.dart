// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'IG Downloader';

  @override
  String get cancel => 'Stornieren';

  @override
  String get save => 'Speichern';

  @override
  String get login => 'Einloggen';

  @override
  String get logout => 'Abmelden';

  @override
  String get understood => 'Habe es';

  @override
  String get delete => 'Löschen';

  @override
  String get deleteAll => 'Alles löschen';

  @override
  String get share => 'Aktie';

  @override
  String get download => 'Herunterladen';

  @override
  String get downloadAgain => 'Nochmals herunterladen';

  @override
  String get saved => 'Heruntergeladen';

  @override
  String get loading => 'Laden';

  @override
  String get apply => 'Anwenden';

  @override
  String get frequentProfilesTitle => 'Kürzlich angesehene Profile';

  @override
  String get frequentProfilesEmptyTitle => 'Noch keine Profile';

  @override
  String get frequentProfilesEmptyMessage =>
      'Die von Ihnen angesehenen Profile werden hier angezeigt.';

  @override
  String get account => 'Konto';

  @override
  String get downloadHistoryTitle => 'Verlauf herunterladen';

  @override
  String get downloadHistoryEmptyTitle => 'Noch kein Inhalt';

  @override
  String get downloadHistoryEmptyMessage =>
      'Sie haben noch keine Inhalte heruntergeladen';

  @override
  String selectedCount(int count) {
    return '$count ausgewählt';
  }

  @override
  String get deleteAllHistoryTitle => 'Gesamten Verlauf löschen?';

  @override
  String get deleteAllHistoryMessage =>
      'Alle Elemente in Ihrem Download-Verlauf werden aus der App entfernt.';

  @override
  String deleteSelectedTitle(int count) {
    return '$count Elemente löschen?';
  }

  @override
  String get deleteSelectedOneMessage =>
      'Das ausgewählte Element wird aus Ihrem Download-Verlauf entfernt.';

  @override
  String deleteSelectedManyMessage(int count) {
    return '$count ausgewählte Elemente werden aus Ihrem Download-Verlauf entfernt.';
  }

  @override
  String get deleteOneTitle => 'Dieses Element löschen?';

  @override
  String get deleteOneMessage =>
      'Dieses Element wird aus Ihrem Download-Verlauf entfernt.';

  @override
  String get cannotShareFileMissing =>
      'Kann nicht geteilt werden. Die Datei ist auf diesem Gerät nicht mehr vorhanden.';

  @override
  String get cannotShareContent => 'Dieser Inhalt kann nicht geteilt werden.';

  @override
  String get cannotSaveAgainFileMissing =>
      'Es kann nicht erneut gespeichert werden. Die Datei ist auf diesem Gerät nicht mehr vorhanden.';

  @override
  String get savedAgainToGallery => 'Nochmals in der Galerie gespeichert.';

  @override
  String get cannotSaveAgainContent =>
      'Dieser Inhalt kann nicht erneut gespeichert werden.';

  @override
  String get cannotOpenFileMissing =>
      'Dieser Inhalt kann nicht geöffnet werden. Die Datei ist auf diesem Gerät nicht mehr vorhanden.';

  @override
  String get video => 'Video';

  @override
  String get image => 'Foto';

  @override
  String get content => 'Inhalt';

  @override
  String get justDownloaded => 'Gerade heruntergeladen';

  @override
  String get heroTitle => 'Laden Sie Inhalte von Instagram herunter';

  @override
  String get heroConnected => 'Instagram ist angeschlossen.';

  @override
  String get heroDescription =>
      'Laden Sie Fotos, Rollen und Geschichten schnell und einfach herunter.';

  @override
  String get downloadByLink => 'Per Link herunterladen';

  @override
  String get invalidLinkTitle => 'Ungültiger Link';

  @override
  String get invalidLinkMessage =>
      'Bitte geben Sie den Instagram-Link für den Beitrag, Reel, Story oder das Video ein, das Sie herunterladen möchten.';

  @override
  String get downloadByLinkInfo1 =>
      'Verwenden Sie dies, wenn Sie bereits einen Link zu einem Instagram-Beitrag, Reel, Story oder Highlight haben.';

  @override
  String get downloadByLinkInfo2 =>
      'Fügen Sie den Link ein und die App prüft den Inhalt und lässt Sie ihn herunterladen.';

  @override
  String get example => 'Beispiel:';

  @override
  String get enterInstagramLink => 'Geben Sie den Link Instagram ein';

  @override
  String get instagramLinkHint =>
      'https://www.instagram.com/p/... oder /reel/...';

  @override
  String get pasteInstagramLinkHint =>
      'Fügen Sie einen Instagram-Link ein, um den gewünschten Inhalt zu überprüfen und herunterzuladen.';

  @override
  String get openInstagram => 'Öffnen Sie Instagram';

  @override
  String get getContent => 'Holen Sie sich Inhalte';

  @override
  String get explainFeature => 'Erklären Sie die Funktion';

  @override
  String get downloadFromProfile => 'Vom Profil herunterladen';

  @override
  String get invalidProfileTitle => 'Ungültige Informationen';

  @override
  String get invalidProfileMessage =>
      'Bitte geben Sie einen Instagram Benutzernamen oder Profillink ein.';

  @override
  String get profileInfo1 =>
      'Verwenden Sie diese Option, wenn Sie mehrere Elemente von einem Instagram-Konto anzeigen und herunterladen möchten.';

  @override
  String get profileInfo2 =>
      'Geben Sie einen Benutzernamen oder einen Profillink ein und wählen Sie dann die Story, Reels oder Beiträge aus, die Sie herunterladen möchten.';

  @override
  String get profileInputLabel => 'Benutzername oder Profillink';

  @override
  String get profileInputHint =>
      'Beispiel: @Benutzername oder instagram.com/Benutzername';

  @override
  String get profileCardDescription =>
      'Geben Sie einen Benutzernamen oder einen Profillink ein, um herunterladbare Stories, Reels und Beiträge anzuzeigen.';

  @override
  String get story => 'Story';

  @override
  String get storiesHighlights => 'Stories / Highlights';

  @override
  String get reels => 'Reels';

  @override
  String get posts => 'Beiträge';

  @override
  String get photosPosts => 'Fotos / Beiträge';

  @override
  String get photosVideos => 'Fotos / Videos';

  @override
  String get profileSummary => 'Profilzusammenfassung';

  @override
  String get storyModeHint =>
      'Geben Sie ein Profil ein, um herunterladbare Stories und Highlights anzuzeigen.';

  @override
  String get reelsModeHint =>
      'Geben Sie ein Profil ein, um die Reels-Liste anzuzeigen.';

  @override
  String get postsModeHint =>
      'Geben Sie ein Profil ein, um herunterladbare Beiträge anzuzeigen.';

  @override
  String get storyPopupTitle => 'Laden Sie Stories vom Profil herunter';

  @override
  String get reelsPopupTitle => 'Laden Sie Reels vom Profil herunter';

  @override
  String get postsPopupTitle => 'Laden Sie Beiträge aus dem Profil herunter';

  @override
  String get viewStory => 'Story anzeigen';

  @override
  String get viewReels => 'Anzeigen';

  @override
  String get viewPosts => 'Beiträge ansehen';

  @override
  String get noStoryOrHighlightAll =>
      'Kein Story oder Highlight gefunden. Melden Sie sich an, wenn für den Inhalt eine Anzeigeberechtigung erforderlich ist.';

  @override
  String get noStoryOrHighlightInput =>
      'Kein Story oder Highlight gefunden. Geben Sie zur Überprüfung ein Instagram-Profil ein.';

  @override
  String get noStoryItems =>
      'Es gibt keinen Inhalt zum Anzeigen oder Sie haben keine Berechtigung, dieses Element anzuzeigen.';

  @override
  String get noFeedAll =>
      'Keine Beiträge oder Videos gefunden. Melden Sie sich an, wenn für den Inhalt eine Anzeigeberechtigung erforderlich ist.';

  @override
  String get noFeedInput =>
      'Noch kein Inhalt. Wählen Sie „Fans“ oder „Beiträge“ und geben Sie dann ein Profil ein.';

  @override
  String get endOfContent => 'Sie sind am Ende des Inhalts angelangt.';

  @override
  String get loadMore => 'Mehr laden';

  @override
  String get loadingMore => 'Mehr laden...';

  @override
  String get cannotShowPostContent =>
      'Der Inhalt dieses Beitrags kann nicht angezeigt werden.';

  @override
  String get chooseItemToDownload =>
      'Wählen Sie ein Element zum Herunterladen aus';

  @override
  String contentCount(int count) {
    return '$count Elemente';
  }

  @override
  String get chooseThemeColor => 'Wählen Sie die Designfarbe';

  @override
  String get themeDefault => 'Standard';

  @override
  String get themeVivid => 'Lebhaft';

  @override
  String get themePink => 'Glänzendes Rosa';

  @override
  String get themeBlue => 'Hellblau';

  @override
  String get themeRed => 'Rot';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get loginRequiredTitle => 'Anmeldung erforderlich';

  @override
  String get followRequiredTitle => 'Folgen erforderlich';

  @override
  String get followRequiredMessage =>
      'Das angemeldete Konto ist nicht berechtigt, diesen Inhalt anzuzeigen.';

  @override
  String get downloadSuccessMessage => 'Erfolgreich heruntergeladen.';

  @override
  String get viewHistory => 'Verlauf anzeigen';

  @override
  String get frequentAccessTooltip => 'Häufig Zugriff';

  @override
  String get recentDownloadsTooltip => 'Neueste Downloads';

  @override
  String get changeThemeTooltip => 'Thema ändern';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get themeSettingTitle => 'Theme';

  @override
  String get languageSettingTitle => 'Sprache';

  @override
  String get chooseLanguageTitle => 'Wählen Sie Ihre Sprache';

  @override
  String get languageVietnameseNative => 'Tiếng Việt';

  @override
  String get languageVietnameseLocal => 'Vietnamese';

  @override
  String get languageEnglishNative => 'English';

  @override
  String get languageEnglishLocal => 'English';

  @override
  String get sessionModeTitle => 'Download-Modus';

  @override
  String get sessionPublicMode => 'Public';

  @override
  String get sessionPrivateMode => 'Private';

  @override
  String get sessionPrivateConnected => 'Ihr Instagram Konto ist verbunden.';

  @override
  String get sessionPrivatePrompt =>
      'Melden Sie sich bei Instagram an, um Inhalte herunterzuladen, die Ihr Konto anzeigen darf.';

  @override
  String get sessionPublicPrompt =>
      'Sie laden öffentliche Inhalte herunter, ohne sich anzumelden.';

  @override
  String get profileReelsListTitle => 'Reel Videoliste';

  @override
  String get profilePostsListTitle => 'Foto / Beitrag Liste';

  @override
  String get close => 'Schließen';

  @override
  String get instagramHome => 'Instagram Startseite';

  @override
  String get selectThisContent => 'Diesen Inhalt auswählen';

  @override
  String get manualOpeningInstagram => 'Öffnen Instagram...';

  @override
  String get manualInstruction =>
      'Öffnen Sie den Beitrag Reel, Story oder Highlight, den Sie herunterladen möchten, und tippen Sie dann auf „Diesen Inhalt auswählen“.';

  @override
  String get manualPickedContent =>
      'Inhalt ausgewählt. Tippen Sie auf „Diesen Inhalt auswählen“, um fortzufahren.';

  @override
  String get manualNoDownloadableContent =>
      'Kein herunterladbarer Inhalt gefunden. Öffnen Sie einen Beitrag, Reel, Story oder Highlight.';

  @override
  String get manualCloseToExit =>
      'Um den Verlust des ausgewählten Inhalts zu vermeiden, tippen Sie auf „Schließen“, wenn Sie den Vorgang beenden möchten.';

  @override
  String get loginOpeningInstagram => 'Öffnen Instagram... Bitte warten.';

  @override
  String get loginInstruction =>
      'Melden Sie sich bei Instagram an und tippen Sie zum Abschluss auf „Speichern“.';

  @override
  String get loginChecking => 'Anmeldung wird überprüft...';

  @override
  String get loginCannotConfirm =>
      'Anmeldung kann nicht bestätigt werden.\nBitte melden Sie sich bei Instagram an und versuchen Sie erneut zu speichern.';

  @override
  String get loginSaveError =>
      'Beim Speichern der Anmeldeinformationen ist ein Fehler aufgetreten. Bitte versuchen Sie es erneut.';

  @override
  String get loginLoggingOut => 'Abmelden...';

  @override
  String get loginLoggedOut =>
      'Sie haben sich von Instagram abgemeldet.\nBitte melden Sie sich erneut an, um fortzufahren.';

  @override
  String get loginSuccessPrompt =>
      'Anmeldung erfolgreich.\nTippen Sie zum Abschluss auf „Speichern“.';

  @override
  String get loginPromptOnLoginPage =>
      'Melden Sie sich bei Instagram an und tippen Sie zum Abschluss auf „Speichern“.';

  @override
  String get loginPromptSaveBottom =>
      'Wenn Sie mit der Anmeldung fertig sind, tippen Sie unten auf „Speichern“.';

  @override
  String get loginPageTitle => 'Melden Sie sich bei Instagram an';

  @override
  String get loginOpeningInstagramWithHint =>
      'Öffnen Instagram...\nTippen Sie nach der Anmeldung auf „Speichern“.';

  @override
  String get loginOpenFailed =>
      'Instagram lässt sich nicht öffnen.\nBitte überprüfen Sie Ihre Internetverbindung und versuchen Sie es erneut.';

  @override
  String get profileSavedMissingUsername =>
      'Im gespeicherten Profil fehlt ein Benutzername.';

  @override
  String get openingProfile => 'Profil öffnen...';

  @override
  String openingUsername(String username) {
    return 'Eröffnung @$username...';
  }

  @override
  String foundStoryHighlightsAndPosts(int storyCount, int postCount) {
    return 'Gefunden $storyCount Story/Highlight Artikel und $postCount Beiträge.';
  }

  @override
  String get privateModeEnabled => 'Private-Modus aktiviert.';

  @override
  String get publicModeEnabled => 'Zurück in den Public-Modus geschaltet.';

  @override
  String get cannotConfirmInstagramLogin =>
      'Instagram Anmeldung kann nicht bestätigt werden. Bitte melden Sie sich erneut an.';

  @override
  String get instagramConnected => 'Instagram Konto verbunden.';

  @override
  String get loggingOutInstagram => 'Abmelden von Instagram...';

  @override
  String get instagramLoggedOut => 'Sie haben sich von Instagram abgemeldet.';

  @override
  String get instagramLogoutCleanupFailed =>
      'Von Instagram abgemeldet, aber beim Löschen der Anmeldedaten ist ein Fehler aufgetreten.';

  @override
  String get emptyInstagramLink => 'Bitte geben Sie einen Instagram-Link ein.';

  @override
  String get preparingContent => 'Inhalte werden vorbereitet...';

  @override
  String get loadingContentWithAccount =>
      'Inhalte werden mit dem verbundenen Konto geladen...';

  @override
  String get cannotFetchContent => 'Inhalte können nicht abgerufen werden.';

  @override
  String get noDownloadableContentFound =>
      'Keine herunterladbaren Inhalte gefunden.';

  @override
  String foundDownloadableContent(int count) {
    return '$count herunterladbare Artikel gefunden.';
  }

  @override
  String get fetchContentFailedPublic =>
      'Inhalte können nicht abgerufen werden. Bitte überprüfen Sie den Link oder versuchen Sie es erneut.';

  @override
  String get fetchContentFailedPrivate =>
      'Inhalte können nicht abgerufen werden. Bitte überprüfen Sie die Anzeigeberechtigung oder melden Sie sich erneut an.';

  @override
  String get emptyProfileInput => 'Bitte geben Sie ein Instagram-Profil ein.';

  @override
  String get loadingStoryHighlights => 'Laden von Stories und Highlights...';

  @override
  String get noCurrentStoryOrHighlight =>
      'Keine aktuelle Story oder Highlight gefunden.';

  @override
  String foundStoryHighlights(int count) {
    return '$count Story/Highlight Artikel gefunden.';
  }

  @override
  String get cannotOpenContent => 'Dieser Inhalt kann nicht geöffnet werden.';

  @override
  String openingStoryGroup(String title) {
    return '„$title“ öffnen...';
  }

  @override
  String foundStoryGroupItems(int count, String title) {
    return '$count Artikel in „$title“ gefunden.';
  }

  @override
  String get cannotOpenStoryHighlightLogin =>
      'Story oder Highlight können nicht geöffnet werden. Bitte melden Sie sich an und versuchen Sie es erneut.';

  @override
  String get cannotOpenStoryHighlightPermission =>
      'Story oder Highlight können nicht geöffnet werden. Bitte prüfen Sie die Einsichtsberechtigung.';

  @override
  String get cannotDownloadContent =>
      'Dieser Inhalt kann nicht heruntergeladen werden.';

  @override
  String get downloadingStory => 'Geschichte wird heruntergeladen...';

  @override
  String savedStoryToAlbum(String albumName) {
    return 'Story-Element im Album $albumName gespeichert.';
  }

  @override
  String get downloadStoryFailed =>
      'Story Download fehlgeschlagen. Bitte versuchen Sie es erneut.';

  @override
  String get loadingReelsPublic => 'Rollen werden abgerufen...';

  @override
  String get loadingReelsPrivate => 'Rollen werden geladen...';

  @override
  String get noReelsOrPermission =>
      'Es wurden keine Dateien gefunden oder Sie haben keine Berechtigung, sie anzuzeigen.';

  @override
  String foundReels(int count) {
    return 'Gefunden $count Reels.';
  }

  @override
  String get cannotLoadReelsPublic =>
      'Die Dateien können nicht geladen werden. Bitte überprüfen Sie das Profil oder versuchen Sie es erneut.';

  @override
  String get cannotLoadReelsPrivate =>
      'Die Dateien können nicht geladen werden. Bitte prüfen Sie die Einsichtsberechtigung.';

  @override
  String get loadingPostsPublic => 'Fotos/Beiträge werden abgerufen...';

  @override
  String get loadingPostsPrivate => 'Fotos/Beiträge werden geladen...';

  @override
  String get noPostsOrPermission =>
      'Es wurden keine Fotos/Beiträge gefunden, oder Sie haben keine Berechtigung, sie anzuzeigen.';

  @override
  String foundPosts(int count) {
    return '$count Fotos/Beiträge gefunden.';
  }

  @override
  String get cannotLoadPostsPublic =>
      'Beiträge können nicht geladen werden. Bitte überprüfen Sie das Profil oder versuchen Sie es erneut.';

  @override
  String get cannotLoadPostsPrivate =>
      'Beiträge können nicht geladen werden. Bitte prüfen Sie die Einsichtsberechtigung.';

  @override
  String get cannotLoadMoreContent =>
      'Es können keine weiteren Inhalte geladen werden.';

  @override
  String get cannotLoadMoreProfile =>
      'Es kann nicht mehr geladen werden. Bitte geben Sie das Profil erneut ein.';

  @override
  String get noMoreNewContent => 'Keine neuen Inhalte mehr.';

  @override
  String loadedMoreContent(int count) {
    return '$count weitere Artikel geladen.';
  }

  @override
  String get loadMoreFailed =>
      'Das Laden weiterer Daten ist fehlgeschlagen. Bitte versuchen Sie es erneut.';

  @override
  String get openingReel => 'Öffnen Reel...';

  @override
  String get openingPost => 'Eröffnungsbeitrag...';

  @override
  String get cannotOpenContentPermission =>
      'Dieser Inhalt kann nicht geöffnet werden. Bitte überprüfen Sie die Anzeigeberechtigung oder versuchen Sie es erneut.';

  @override
  String get downloadingContent => 'Inhalte werden heruntergeladen...';

  @override
  String savedToAlbum(String albumName) {
    return 'Im Album $albumName gespeichert.';
  }

  @override
  String savedContentToAlbum(String albumName) {
    return 'Inhalte im Album $albumName gespeichert.';
  }

  @override
  String get downloadContentErrorRetry =>
      'Der Download des Inhalts ist fehlgeschlagen. Tippen Sie, um es erneut zu versuchen.';

  @override
  String get downloadHistoryCleared => 'Download-Verlauf gelöscht.';

  @override
  String downloadHistoryItemsRemoved(int count) {
    return '$count Elemente aus dem Verlauf entfernt.';
  }

  @override
  String get downloadConnectionSlow =>
      'Der Download ist aufgrund einer langsamen Verbindung fehlgeschlagen. Tippen Sie, um es noch einmal zu versuchen.';

  @override
  String get downloadNetworkUnavailable =>
      'Es kann keine Verbindung zum Netzwerk/CDN hergestellt werden. Überprüfen Sie Ihr Netzwerk und versuchen Sie es erneut.';

  @override
  String get downloadCancelled => 'Download abgebrochen.';

  @override
  String get downloadGenericError =>
      'Download fehlgeschlagen. Tippen Sie, um es noch einmal zu versuchen.';

  @override
  String downloadProgress(String percent) {
    return 'Inhalte werden heruntergeladen: $percent %';
  }

  @override
  String get legalLinksTitle => 'Datenschutzrichtlinie & Nutzungsbedingungen';

  @override
  String get termsOfUse => 'Nutzungsbedingungen';

  @override
  String get privacyPolicy => 'Datenschutzrichtlinie';
}
