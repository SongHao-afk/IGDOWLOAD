// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'IG Downloader';

  @override
  String get cancel => 'Annuler';

  @override
  String get save => 'Enregistrer';

  @override
  String get login => 'Connexion';

  @override
  String get logout => 'Déconnexion';

  @override
  String get understood => 'Compris';

  @override
  String get delete => 'Supprimer';

  @override
  String get deleteAll => 'Tout supprimer';

  @override
  String get share => 'Partager';

  @override
  String get download => 'Télécharger';

  @override
  String get downloadAgain => 'Télécharger à nouveau';

  @override
  String get saved => 'Téléchargé';

  @override
  String get loading => 'Chargement';

  @override
  String get apply => 'Appliquer';

  @override
  String get frequentProfilesTitle => 'Profils récemment consultés';

  @override
  String get frequentProfilesEmptyTitle => 'Aucun profil pour l\'instant';

  @override
  String get frequentProfilesEmptyMessage =>
      'Les profils que vous avez consultés apparaîtront ici.';

  @override
  String get account => 'Compte';

  @override
  String get downloadHistoryTitle => 'Historique de téléchargement';

  @override
  String get downloadHistoryEmptyTitle => 'Aucun contenu encore';

  @override
  String get downloadHistoryEmptyMessage =>
      'Vous n\'avez encore téléchargé aucun contenu';

  @override
  String selectedCount(int count) {
    return '$count sélectionné';
  }

  @override
  String get deleteAllHistoryTitle => 'Supprimer tout l\'historique ?';

  @override
  String get deleteAllHistoryMessage =>
      'Tous les éléments de votre historique de téléchargement seront supprimés de l\'application.';

  @override
  String deleteSelectedTitle(int count) {
    return 'Supprimer $count éléments ?';
  }

  @override
  String get deleteSelectedOneMessage =>
      'L\'élément sélectionné sera supprimé de votre historique de téléchargement.';

  @override
  String deleteSelectedManyMessage(int count) {
    return '$count Les éléments sélectionnés seront supprimés de votre historique de téléchargement.';
  }

  @override
  String get deleteOneTitle => 'Supprimer cet élément ?';

  @override
  String get deleteOneMessage =>
      'Cet élément sera supprimé de votre historique de téléchargement.';

  @override
  String get cannotShareFileMissing =>
      'Impossible de partager. Le fichier n\'existe plus sur cet appareil.';

  @override
  String get cannotShareContent => 'Impossible de partager ce contenu.';

  @override
  String get cannotSaveAgainFileMissing =>
      'Impossible de réenregistrer. Le fichier n\'existe plus sur cet appareil.';

  @override
  String get savedAgainToGallery => 'Enregistré à nouveau dans la galerie.';

  @override
  String get cannotSaveAgainContent =>
      'Impossible d\'enregistrer à nouveau ce contenu.';

  @override
  String get cannotOpenFileMissing =>
      'Impossible d\'ouvrir ce contenu. Le fichier n\'existe plus sur cet appareil.';

  @override
  String get video => 'Vidéo';

  @override
  String get image => 'Photo';

  @override
  String get content => 'Contenu';

  @override
  String get justDownloaded => 'Je viens de télécharger';

  @override
  String get heroTitle => 'Télécharger du contenu depuis Instagram';

  @override
  String get heroConnected => 'Instagram est connecté.';

  @override
  String get heroDescription =>
      'Téléchargez des photos, des bobines et des histoires rapidement et facilement.';

  @override
  String get downloadByLink => 'Télécharger par lien';

  @override
  String get invalidLinkTitle => 'Lien invalide';

  @override
  String get invalidLinkMessage =>
      'Veuillez saisir le lien Instagram de la publication, Reel, Story ou de la vidéo que vous souhaitez télécharger.';

  @override
  String get downloadByLinkInfo1 =>
      'Utilisez-le lorsque vous disposez déjà d\'un lien vers une publication Instagram, Reel, Story ou Highlight.';

  @override
  String get downloadByLinkInfo2 =>
      'Collez le lien et l\'application vérifiera le contenu et vous permettra de le télécharger.';

  @override
  String get example => 'Exemple:';

  @override
  String get enterInstagramLink => 'Entrez le lien Instagram';

  @override
  String get instagramLinkHint =>
      'https://www.instagram.com/p/... ou /reel/...';

  @override
  String get pasteInstagramLinkHint =>
      'Collez un lien Instagram pour vérifier et télécharger le contenu souhaité.';

  @override
  String get openInstagram => 'Ouvrir Instagram';

  @override
  String get getContent => 'Obtenir du contenu';

  @override
  String get explainFeature => 'Expliquer la fonctionnalité';

  @override
  String get downloadFromProfile => 'Télécharger depuis le profil';

  @override
  String get invalidProfileTitle => 'Informations invalides';

  @override
  String get invalidProfileMessage =>
      'Veuillez saisir un nom d\'utilisateur Instagram ou un lien de profil.';

  @override
  String get profileInfo1 =>
      'Utilisez-le lorsque vous souhaitez afficher et télécharger plusieurs éléments à partir d\'un compte Instagram.';

  @override
  String get profileInfo2 =>
      'Saisissez un nom d\'utilisateur ou un lien de profil, puis choisissez les Story, Reel ou les publications que vous souhaitez télécharger.';

  @override
  String get profileInputLabel => 'Nom d\'utilisateur ou lien de profil';

  @override
  String get profileInputHint =>
      'Exemple : @username ou instagram.com/username';

  @override
  String get profileCardDescription =>
      'Saisissez un nom d\'utilisateur ou un lien de profil pour afficher les Stories, les Reel et les publications téléchargeables.';

  @override
  String get story => 'Story';

  @override
  String get storiesHighlights => 'Stories / Highlights';

  @override
  String get reels => 'c\'est';

  @override
  String get posts => 'Messages';

  @override
  String get photosPosts => 'Photos/Messages';

  @override
  String get photosVideos => 'Photos/Vidéos';

  @override
  String get profileSummary => 'Résumé du profil';

  @override
  String get storyModeHint =>
      'Entrez un profil pour afficher les Stories et Highlight téléchargeables.';

  @override
  String get reelsModeHint => 'Entrez un profil pour afficher la liste.';

  @override
  String get postsModeHint =>
      'Entrez un profil pour afficher les publications téléchargeables.';

  @override
  String get storyPopupTitle => 'Télécharger Stories depuis le profil';

  @override
  String get reelsPopupTitle => 'Télécharger les Reel à partir du profil';

  @override
  String get postsPopupTitle => 'Télécharger les messages depuis le profil';

  @override
  String get viewStory => 'Voir Story';

  @override
  String get viewReels => 'Voir les';

  @override
  String get viewPosts => 'Afficher les messages';

  @override
  String get noStoryOrHighlightAll =>
      'Aucun Story ou Highlight trouvé. Connectez-vous si le contenu nécessite une autorisation de visualisation.';

  @override
  String get noStoryOrHighlightInput =>
      'Aucun Story ou Highlight trouvé. Saisissez un profil Instagram pour vérifier.';

  @override
  String get noStoryItems =>
      'Il n\'y a aucun contenu à afficher ou vous n\'êtes pas autorisé à afficher cet élément.';

  @override
  String get noFeedAll =>
      'Aucun message ou vidéo trouvé. Connectez-vous si le contenu nécessite une autorisation de visualisation.';

  @override
  String get noFeedInput =>
      'Pas de contenu pour l\'instant. Choisissez Reels ou Posts, puis saisissez un profil.';

  @override
  String get endOfContent => 'Vous avez atteint la fin du contenu.';

  @override
  String get loadMore => 'Charger plus';

  @override
  String get loadingMore => 'Chargement plus...';

  @override
  String get cannotShowPostContent =>
      'Impossible d\'afficher le contenu de cet article.';

  @override
  String get chooseItemToDownload => 'Choisissez un élément à télécharger';

  @override
  String contentCount(int count) {
    return '$count éléments';
  }

  @override
  String get chooseThemeColor => 'Choisissez la couleur du thème';

  @override
  String get themeDefault => 'Par défaut';

  @override
  String get themeVivid => 'Vif';

  @override
  String get themePink => 'Rose brillant';

  @override
  String get themeBlue => 'Bleu clair';

  @override
  String get themeRed => 'Rouge';

  @override
  String get themeDark => 'Foncé';

  @override
  String get loginRequiredTitle => 'Connexion requise';

  @override
  String get followRequiredTitle => 'Suivez requis';

  @override
  String get followRequiredMessage =>
      'Le compte connecté n\'est pas autorisé à afficher ce contenu.';

  @override
  String get downloadSuccessMessage => 'Téléchargé avec succès.';

  @override
  String get viewHistory => 'Afficher l\'historique';

  @override
  String get frequentAccessTooltip => 'Fréquent accès';

  @override
  String get recentDownloadsTooltip => 'Téléchargements récents';

  @override
  String get changeThemeTooltip => 'Changer de thème';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get themeSettingTitle => 'Thème';

  @override
  String get languageSettingTitle => 'Langue';

  @override
  String get chooseLanguageTitle => 'Choisissez votre langue';

  @override
  String get languageVietnameseNative => 'Tiếng Việt';

  @override
  String get languageVietnameseLocal => 'Vietnamese';

  @override
  String get languageEnglishNative => 'English';

  @override
  String get languageEnglishLocal => 'English';

  @override
  String get sessionModeTitle => 'Mode de téléchargement';

  @override
  String get sessionPublicMode => 'Public';

  @override
  String get sessionPrivateMode => 'Private';

  @override
  String get sessionPrivateConnected => 'Votre compte Instagram est connecté.';

  @override
  String get sessionPrivatePrompt =>
      'Connectez-vous à Instagram pour télécharger le contenu que votre compte est autorisé à voir.';

  @override
  String get sessionPublicPrompt =>
      'Vous téléchargez du contenu public sans vous connecter.';

  @override
  String get profileReelsListTitle => 'Reel liste de vidéos';

  @override
  String get profilePostsListTitle => 'Photo / Post liste';

  @override
  String get close => 'Fermer';

  @override
  String get instagramHome => 'Instagram accueil';

  @override
  String get selectThisContent => 'Sélectionner ce contenu';

  @override
  String get manualOpeningInstagram => 'Ouverture Instagram...';

  @override
  String get manualInstruction =>
      'Ouvrez la publication, Reel, Story ou Highlight que vous souhaitez télécharger, puis appuyez sur « Sélectionner ce contenu ».';

  @override
  String get manualPickedContent =>
      'Contenu sélectionné. Appuyez sur « Sélectionner ce contenu » pour continuer.';

  @override
  String get manualNoDownloadableContent =>
      'Aucun contenu téléchargeable trouvé. Ouvrez une publication, Reel, Story ou Highlight.';

  @override
  String get manualCloseToExit =>
      'Pour éviter de perdre le contenu sélectionné, appuyez sur « Fermer » si vous souhaitez quitter.';

  @override
  String get loginOpeningInstagram =>
      'Ouverture Instagram... Veuillez patienter.';

  @override
  String get loginInstruction =>
      'Connectez-vous à Instagram, puis appuyez sur « Enregistrer » pour terminer.';

  @override
  String get loginChecking => 'Vérification de la connexion...';

  @override
  String get loginCannotConfirm =>
      'Impossible de confirmer la connexion.\nVeuillez vous connecter à Instagram et réessayer d\'enregistrer.';

  @override
  String get loginSaveError =>
      'Une erreur s\'est produite lors de l\'enregistrement des informations de connexion. Veuillez réessayer.';

  @override
  String get loginLoggingOut => 'Déconnexion...';

  @override
  String get loginLoggedOut =>
      'Vous êtes déconnecté de Instagram.\nVeuillez vous reconnecter pour continuer.';

  @override
  String get loginSuccessPrompt =>
      'Connexion réussie.\nAppuyez sur \"Enregistrer\" pour terminer.';

  @override
  String get loginPromptOnLoginPage =>
      'Connectez-vous à Instagram, puis appuyez sur « Enregistrer » pour terminer.';

  @override
  String get loginPromptSaveBottom =>
      'Si vous avez fini de vous connecter, appuyez sur « Enregistrer » ci-dessous.';

  @override
  String get loginPageTitle => 'Connectez-vous à Instagram';

  @override
  String get loginOpeningInstagramWithHint =>
      'Ouverture Instagram...\nAprès vous être connecté, appuyez sur « Enregistrer ».';

  @override
  String get loginOpenFailed =>
      'Impossible d\'ouvrir Instagram.\nVeuillez vérifier votre connexion Internet et réessayer.';

  @override
  String get profileSavedMissingUsername =>
      'Il manque un nom d\'utilisateur dans le profil enregistré.';

  @override
  String get openingProfile => 'Profil d\'ouverture...';

  @override
  String openingUsername(String username) {
    return 'Ouverture @$username...';
  }

  @override
  String foundStoryHighlightsAndPosts(int storyCount, int postCount) {
    return '$storyCount Story/Highlight articles et $postCount messages trouvés.';
  }

  @override
  String get privateModeEnabled => 'Mode Private activé.';

  @override
  String get publicModeEnabled => 'Revenir au mode Public.';

  @override
  String get cannotConfirmInstagramLogin =>
      'Impossible de confirmer la connexion Instagram. Veuillez vous reconnecter.';

  @override
  String get instagramConnected => 'Instagram compte connecté.';

  @override
  String get loggingOutInstagram => 'Déconnexion de Instagram...';

  @override
  String get instagramLoggedOut => 'Vous vous êtes déconnecté de Instagram.';

  @override
  String get instagramLogoutCleanupFailed =>
      'Déconnecté de Instagram, mais une erreur s\'est produite lors de la suppression des données de connexion.';

  @override
  String get emptyInstagramLink => 'Veuillez saisir un lien Instagram.';

  @override
  String get preparingContent => 'Préparation du contenu...';

  @override
  String get loadingContentWithAccount =>
      'Chargement du contenu avec le compte connecté...';

  @override
  String get cannotFetchContent => 'Impossible de récupérer le contenu.';

  @override
  String get noDownloadableContentFound =>
      'Aucun contenu téléchargeable trouvé.';

  @override
  String foundDownloadableContent(int count) {
    return 'Éléments téléchargeables $count trouvés.';
  }

  @override
  String get fetchContentFailedPublic =>
      'Impossible de récupérer le contenu. Veuillez vérifier le lien ou réessayer.';

  @override
  String get fetchContentFailedPrivate =>
      'Impossible de récupérer le contenu. Veuillez vérifier l\'autorisation de visualisation ou vous reconnecter.';

  @override
  String get emptyProfileInput => 'Veuillez saisir un profil Instagram.';

  @override
  String get loadingStoryHighlights => 'Chargement Stories et Highlights...';

  @override
  String get noCurrentStoryOrHighlight =>
      'Aucun article actuel ou point culminant trouvé.';

  @override
  String foundStoryHighlights(int count) {
    return 'Articles $count Story/Highlight trouvés.';
  }

  @override
  String get cannotOpenContent => 'Impossible d\'ouvrir ce contenu.';

  @override
  String openingStoryGroup(String title) {
    return 'Ouverture de \"$title\"...';
  }

  @override
  String foundStoryGroupItems(int count, String title) {
    return 'Éléments $count trouvés dans \"$title\".';
  }

  @override
  String get cannotOpenStoryHighlightLogin =>
      'Impossible d\'ouvrir Story ou Highlight. Veuillez vous connecter et réessayer.';

  @override
  String get cannotOpenStoryHighlightPermission =>
      'Impossible d\'ouvrir Story ou Highlight. Veuillez vérifier l\'autorisation de visualisation.';

  @override
  String get cannotDownloadContent => 'Impossible de télécharger ce contenu.';

  @override
  String get downloadingStory => 'Téléchargement de l\'histoire...';

  @override
  String savedStoryToAlbum(String albumName) {
    return 'Élément de l\'histoire enregistré dans l\'album $albumName.';
  }

  @override
  String get downloadStoryFailed =>
      'Story Le téléchargement a échoué. Veuillez réessayer.';

  @override
  String get loadingReelsPublic => 'Récupération des bobines...';

  @override
  String get loadingReelsPrivate => 'Chargement des bobines...';

  @override
  String get noReelsOrPermission =>
      'Aucun fichier n\'est trouvé ou vous n\'êtes pas autorisé à les afficher.';

  @override
  String foundReels(int count) {
    return 'Trouvé des $count Reels.';
  }

  @override
  String get cannotLoadReelsPublic =>
      'Impossible de charger les Reels. Veuillez vérifier le profil ou réessayer.';

  @override
  String get cannotLoadReelsPrivate =>
      'Impossible de charger les Reels. Veuillez vérifier l\'autorisation de visualisation.';

  @override
  String get loadingPostsPublic => 'Récupération de photos/posts...';

  @override
  String get loadingPostsPrivate => 'Chargement de photos/posts...';

  @override
  String get noPostsOrPermission =>
      'Aucune photo/post trouvé, ou vous n\'êtes pas autorisé à les visualiser.';

  @override
  String foundPosts(int count) {
    return 'J\'ai trouvé $count photos/messages.';
  }

  @override
  String get cannotLoadPostsPublic =>
      'Impossible de charger les messages. Veuillez vérifier le profil ou réessayer.';

  @override
  String get cannotLoadPostsPrivate =>
      'Impossible de charger les messages. Veuillez vérifier l\'autorisation de visualisation.';

  @override
  String get cannotLoadMoreContent => 'Impossible de charger plus de contenu.';

  @override
  String get cannotLoadMoreProfile =>
      'Impossible de charger davantage. Veuillez saisir à nouveau le profil.';

  @override
  String get noMoreNewContent => 'Plus de nouveau contenu.';

  @override
  String loadedMoreContent(int count) {
    return 'Chargé $count plus d\'articles.';
  }

  @override
  String get loadMoreFailed =>
      'Échec du chargement supplémentaire. Veuillez réessayer.';

  @override
  String get openingReel => 'Ouverture Reel...';

  @override
  String get openingPost => 'Message d\'ouverture...';

  @override
  String get cannotOpenContentPermission =>
      'Impossible d\'ouvrir ce contenu. Veuillez vérifier l\'autorisation de visualisation ou réessayer.';

  @override
  String get downloadingContent => 'Téléchargement du contenu...';

  @override
  String savedToAlbum(String albumName) {
    return 'Enregistré dans l\'album $albumName.';
  }

  @override
  String savedContentToAlbum(String albumName) {
    return 'Contenu enregistré dans l\'album $albumName.';
  }

  @override
  String get downloadContentErrorRetry =>
      'Le téléchargement du contenu a échoué. Appuyez pour réessayer.';

  @override
  String get downloadHistoryCleared => 'Historique de téléchargement effacé.';

  @override
  String downloadHistoryItemsRemoved(int count) {
    return 'Suppression de $count éléments de l\'historique.';
  }

  @override
  String get downloadConnectionSlow =>
      'Le téléchargement a échoué en raison d\'une connexion lente. Appuyez pour réessayer.';

  @override
  String get downloadNetworkUnavailable =>
      'Impossible de se connecter au réseau/CDN. Vérifiez votre réseau et réessayez.';

  @override
  String get downloadCancelled => 'Téléchargement annulé.';

  @override
  String get downloadGenericError =>
      'Échec du téléchargement. Appuyez pour réessayer.';

  @override
  String downloadProgress(String percent) {
    return 'Téléchargement du contenu : $percent%';
  }
}
