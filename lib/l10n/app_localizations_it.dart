// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// The translations for it (`it`).
class AppLocalizationsIt extends AppLocalizationsEn {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appName => 'IG Downloader';

  @override
  String get cancel => 'Cancellare';

  @override
  String get save => 'Salva';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Esci';

  @override
  String get understood => 'Fatto';

  @override
  String get delete => 'Eliminare';

  @override
  String get deleteAll => 'Elimina tutto';

  @override
  String get share => 'Condividere';

  @override
  String get download => 'Scaricamento';

  @override
  String get downloadAgain => 'Scarica di nuovo';

  @override
  String get saved => 'Scaricato';

  @override
  String get loading => 'Caricamento';

  @override
  String get apply => 'Fare domanda a';

  @override
  String get frequentProfilesTitle => 'Profili visualizzati di recente';

  @override
  String get frequentProfilesEmptyTitle => 'Nessun profilo ancora';

  @override
  String get frequentProfilesEmptyMessage =>
      'I profili che hai visualizzato appariranno qui.';

  @override
  String get account => 'Account';

  @override
  String get downloadHistoryTitle => 'Scarica la cronologia';

  @override
  String get downloadHistoryEmptyTitle => 'Nessun contenuto ancora';

  @override
  String get downloadHistoryEmptyMessage =>
      'Non hai ancora scaricato alcun contenuto';

  @override
  String selectedCount(int count) {
    return '${count} selezionato';
  }

  @override
  String get deleteAllHistoryTitle => 'Eliminare tutta la cronologia?';

  @override
  String get deleteAllHistoryMessage =>
      'Tutti gli elementi nella cronologia dei download verranno rimossi dall\'app.';

  @override
  String deleteSelectedTitle(int count) {
    return 'Eliminare ${count} elementi?';
  }

  @override
  String get deleteSelectedOneMessage =>
      'L\'elemento selezionato verrà rimosso dalla cronologia dei download.';

  @override
  String deleteSelectedManyMessage(int count) {
    return '${count} gli elementi selezionati verranno rimossi dalla cronologia dei download.';
  }

  @override
  String get deleteOneTitle => 'Eliminare questo elemento?';

  @override
  String get deleteOneMessage =>
      'Questo elemento verrà rimosso dalla cronologia dei download.';

  @override
  String get cannotShareFileMissing =>
      'Impossibile condividere. Il file non esiste più su questo dispositivo.';

  @override
  String get cannotShareContent => 'Impossibile condividere questo contenuto.';

  @override
  String get cannotSaveAgainFileMissing =>
      'Impossibile salvare di nuovo. Il file non esiste più su questo dispositivo.';

  @override
  String get savedAgainToGallery => 'Salvato di nuovo nella galleria.';

  @override
  String get cannotSaveAgainContent =>
      'Impossibile salvare nuovamente questo contenuto.';

  @override
  String get cannotOpenFileMissing =>
      'Impossibile aprire questo contenuto. Il file non esiste più su questo dispositivo.';

  @override
  String get video => 'Video';

  @override
  String get image => 'Foto';

  @override
  String get content => 'Contenuto';

  @override
  String get justDownloaded => 'Appena scaricato';

  @override
  String get heroTitle => 'Scarica contenuti da Instagram';

  @override
  String get heroConnected => 'Instagram è connesso.';

  @override
  String get heroDescription =>
      'Scarica foto, filmati e storie in modo rapido e semplice.';

  @override
  String get downloadByLink => 'Scarica tramite collegamento';

  @override
  String get invalidLinkTitle => 'Link non valido';

  @override
  String get invalidLinkMessage =>
      'Inserisci il collegamento Instagram per il post, Reel, Story o video che desideri scaricare.';

  @override
  String get downloadByLinkInfo1 =>
      'Utilizza questo quando hai già un collegamento a un Instagram post, Reel, Story o Highlight.';

  @override
  String get downloadByLinkInfo2 =>
      'Incolla il collegamento e l\'app controllerà il contenuto e ti consentirà di scaricarlo.';

  @override
  String get example => 'Esempio:';

  @override
  String get enterInstagramLink => 'Inserisci Instagram collegamento';

  @override
  String get instagramLinkHint => 'https://www.instagram.com/p/... o /reel/...';

  @override
  String get pasteInstagramLinkHint =>
      'Incolla un collegamento Instagram per verificare e scaricare il contenuto desiderato.';

  @override
  String get openInstagram => 'Apri Instagram';

  @override
  String get getContent => 'Ottieni contenuto';

  @override
  String get explainFeature => 'Spiega funzionalità';

  @override
  String get downloadFromProfile => 'Scarica dal profilo';

  @override
  String get invalidProfileTitle => 'Informazioni non valide';

  @override
  String get invalidProfileMessage =>
      'Inserisci un nome utente o un collegamento al profilo Instagram.';

  @override
  String get profileInfo1 =>
      'Utilizza questo quando desideri visualizzare e scaricare più elementi da un account Instagram.';

  @override
  String get profileInfo2 =>
      'Inserisci un nome utente o un collegamento al profilo, quindi scegli Story, Reel o post che desideri scaricare.';

  @override
  String get profileInputLabel => 'Nome utente o collegamento al profilo';

  @override
  String get profileInputHint =>
      'Esempio: @nomeutente o instagram.com/nomeutente';

  @override
  String get profileCardDescription =>
      'Inserisci un nome utente o un collegamento al profilo per visualizzare Stories, Reels e post scaricabili.';

  @override
  String get story => 'Story';

  @override
  String get storiesHighlights => 'Stories / Highlights';

  @override
  String get reels => 'Reels';

  @override
  String get posts => 'Post';

  @override
  String get photosPosts => 'Foto/Post';

  @override
  String get photosVideos => 'Foto/Video';

  @override
  String get profileSummary => 'Riepilogo profilo';

  @override
  String get storyModeHint =>
      'Inserisci un profilo per visualizzare Stories e Highlights scaricabili.';

  @override
  String get reelsModeHint =>
      'Inserisci un profilo per visualizzare l\'elenco Reel.';

  @override
  String get postsModeHint =>
      'Inserisci un profilo per visualizzare i post scaricabili.';

  @override
  String get storyPopupTitle => 'Scarica Stories dal profilo';

  @override
  String get reelsPopupTitle => 'Scarica Reel dal profilo';

  @override
  String get postsPopupTitle => 'Scarica post dal profilo';

  @override
  String get viewStory => 'Visualizza Story';

  @override
  String get viewReels => 'Visualizza Reels';

  @override
  String get viewPosts => 'Visualizza post';

  @override
  String get noStoryOrHighlightAll =>
      'Nessun Story o Highlight trovato. Accedi se il contenuto richiede l\'autorizzazione alla visualizzazione.';

  @override
  String get noStoryOrHighlightInput =>
      'Nessun Story o Highlight trovato. Inserisci un profilo Instagram da controllare.';

  @override
  String get noStoryItems =>
      'Non ci sono contenuti da visualizzare o non hai l\'autorizzazione per visualizzare questo elemento.';

  @override
  String get noFeedAll =>
      'Nessun post o video trovato. Accedi se il contenuto richiede l\'autorizzazione alla visualizzazione.';

  @override
  String get noFeedInput =>
      'Ancora nessun contenuto. Scegli Reels o Post, quindi inserisci un profilo.';

  @override
  String get endOfContent => 'Hai raggiunto la fine del contenuto.';

  @override
  String get loadMore => 'Carica altro';

  @override
  String get loadingMore => 'Caricamento altro...';

  @override
  String get cannotShowPostContent =>
      'Impossibile visualizzare il contenuto di questo post.';

  @override
  String get chooseItemToDownload => 'Scegli un elemento da scaricare';

  @override
  String contentCount(int count) {
    return '${count} articoli';
  }

  @override
  String get chooseThemeColor => 'Scegli il colore del tema';

  @override
  String get themeDefault => 'Predefinito';

  @override
  String get themeVivid => 'Vivido';

  @override
  String get themePink => 'Rosa lucido';

  @override
  String get themeBlue => 'Azzurro';

  @override
  String get themeRed => 'Rosso';

  @override
  String get themeDark => 'Buio';

  @override
  String get loginRequiredTitle => 'È richiesto l\'accesso';

  @override
  String get followRequiredTitle => 'Seguire obbligatorio';

  @override
  String get followRequiredMessage =>
      'L\'account che ha effettuato l\'accesso non dispone dell\'autorizzazione per visualizzare questo contenuto.';

  @override
  String get downloadSuccessMessage => 'Scaricato con successo.';

  @override
  String get viewHistory => 'Visualizza la cronologia';

  @override
  String get frequentAccessTooltip => 'Accesso frequente';

  @override
  String get recentDownloadsTooltip => 'Download recenti';

  @override
  String get changeThemeTooltip => 'Cambia tema';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get themeSettingTitle => 'Tema';

  @override
  String get languageSettingTitle => 'Lingua';

  @override
  String get chooseLanguageTitle => 'Scegli la tua lingua';

  @override
  String get languageVietnameseNative => 'Tiếng Việt';

  @override
  String get languageVietnameseLocal => 'Vietnamese';

  @override
  String get languageEnglishNative => 'English';

  @override
  String get languageEnglishLocal => 'English';

  @override
  String get sessionModeTitle => 'Modalità di download';

  @override
  String get sessionPublicMode => 'Public';

  @override
  String get sessionPrivateMode => 'Private';

  @override
  String get sessionPrivateConnected => 'Il tuo account Instagram è collegato.';

  @override
  String get sessionPrivatePrompt =>
      'Accedi a Instagram per scaricare i contenuti che il tuo account può visualizzare.';

  @override
  String get sessionPublicPrompt =>
      'Stai scaricando contenuti pubblici senza effettuare l\'accesso.';

  @override
  String get profileReelsListTitle => 'Reel elenco dei video';

  @override
  String get profilePostsListTitle => 'Elenco foto/post';

  @override
  String get close => 'Vicino';

  @override
  String get instagramHome => 'Instagram casa';

  @override
  String get selectThisContent => 'Seleziona questo contenuto';

  @override
  String get manualOpeningInstagram => 'Apertura Instagram...';

  @override
  String get manualInstruction =>
      'Apri il post, Reel, Story o Highlight che desideri scaricare, quindi tocca "Seleziona questo contenuto".';

  @override
  String get manualPickedContent =>
      'Contenuto selezionato. Tocca "Seleziona questo contenuto" per continuare.';

  @override
  String get manualNoDownloadableContent =>
      'Nessun contenuto scaricabile trovato. Apri un post, Reel, Story o Highlight.';

  @override
  String get manualCloseToExit =>
      'Per evitare di perdere il contenuto selezionato, toccare "Chiudi" se si desidera uscire.';

  @override
  String get loginOpeningInstagram => 'Apertura Instagram... Attendere.';

  @override
  String get loginInstruction =>
      'Accedi a Instagram, quindi tocca "Salva" per terminare.';

  @override
  String get loginChecking => 'Verifica accesso...';

  @override
  String get loginCannotConfirm =>
      'Impossibile confermare l\'accesso.\nAccedi a Instagram e prova a salvare di nuovo.';

  @override
  String get loginSaveError =>
      'Si è verificato un errore durante il salvataggio delle informazioni di accesso. Riprova.';

  @override
  String get loginLoggingOut => 'Disconnessione...';

  @override
  String get loginLoggedOut =>
      'Sei uscito da Instagram.\nEffettua nuovamente l\'accesso per continuare.';

  @override
  String get loginSuccessPrompt =>
      'Accesso riuscito.\nTocca "Salva" per terminare.';

  @override
  String get loginPromptOnLoginPage =>
      'Accedi a Instagram, quindi tocca "Salva" per terminare.';

  @override
  String get loginPromptSaveBottom =>
      'Se hai terminato l\'accesso, tocca "Salva" di seguito.';

  @override
  String get loginPageTitle => 'Accedi a Instagram';

  @override
  String get loginOpeningInstagramWithHint =>
      'Apertura Instagram...\nDopo aver effettuato l\'accesso, toccare "Salva".';

  @override
  String get loginOpenFailed =>
      'Impossibile aprire Instagram.\nControlla la connessione Internet e riprova.';

  @override
  String get profileSavedMissingUsername =>
      'Nel profilo salvato manca un nome utente.';

  @override
  String get openingProfile => 'Apertura profilo...';

  @override
  String openingUsername(String username) {
    return 'Apertura @${username}...';
  }

  @override
  String foundStoryHighlightsAndPosts(int storyCount, int postCount) {
    return 'Trovato ${storyCount} Story/Highlight elementi e ${postCount} post.';
  }

  @override
  String get privateModeEnabled => 'Private modalità attivata.';

  @override
  String get publicModeEnabled => 'Tornato alla modalità Public.';

  @override
  String get cannotConfirmInstagramLogin =>
      'Impossibile confermare l\'accesso Instagram. Effettua nuovamente l\'accesso.';

  @override
  String get instagramConnected => 'Instagram account collegato.';

  @override
  String get loggingOutInstagram => 'Disconnessione da Instagram...';

  @override
  String get instagramLoggedOut => 'Ti sei disconnesso da Instagram.';

  @override
  String get instagramLogoutCleanupFailed =>
      'Disconnesso da Instagram, ma si è verificato un errore durante la cancellazione dei dati di accesso.';

  @override
  String get emptyInstagramLink => 'Inserisci un link Instagram.';

  @override
  String get preparingContent => 'Preparazione dei contenuti...';

  @override
  String get loadingContentWithAccount =>
      'Caricamento del contenuto con l\'account connesso...';

  @override
  String get cannotFetchContent => 'Impossibile recuperare il contenuto.';

  @override
  String get noDownloadableContentFound =>
      'Nessun contenuto scaricabile trovato.';

  @override
  String foundDownloadableContent(int count) {
    return 'Trovati ${count} elementi scaricabili.';
  }

  @override
  String get fetchContentFailedPublic =>
      'Impossibile recuperare il contenuto. Controlla il collegamento o riprova.';

  @override
  String get fetchContentFailedPrivate =>
      'Impossibile recuperare il contenuto. Controlla i permessi di visualizzazione o accedi nuovamente.';

  @override
  String get emptyProfileInput => 'Inserisci un profilo Instagram.';

  @override
  String get loadingStoryHighlights => 'Caricamento Stories e Highlights...';

  @override
  String get noCurrentStoryOrHighlight =>
      'Nessuna storia attuale o highlight trovato.';

  @override
  String foundStoryHighlights(int count) {
    return 'Trovati ${count} Story/Highlight articoli.';
  }

  @override
  String get cannotOpenContent => 'Impossibile aprire questo contenuto.';

  @override
  String openingStoryGroup(String title) {
    return 'Apertura di "${title}"...';
  }

  @override
  String foundStoryGroupItems(int count, String title) {
    return 'Trovati ${count} oggetti in "${title}".';
  }

  @override
  String get cannotOpenStoryHighlightLogin =>
      'Impossibile aprire Story o Highlight. Effettua l\'accesso e riprova.';

  @override
  String get cannotOpenStoryHighlightPermission =>
      'Impossibile aprire Story o Highlight. Si prega di verificare i permessi di visualizzazione.';

  @override
  String get cannotDownloadContent => 'Impossibile scaricare questo contenuto.';

  @override
  String get downloadingStory => 'Download della storia...';

  @override
  String savedStoryToAlbum(String albumName) {
    return 'Elemento della storia salvato nell\'album ${albumName}.';
  }

  @override
  String get downloadStoryFailed =>
      'Story download non riuscito. Per favore riprova.';

  @override
  String get loadingReelsPublic => 'Recupero bobine in corso...';

  @override
  String get loadingReelsPrivate => 'Caricamento bobine...';

  @override
  String get noReelsOrPermission =>
      'Nessun elemento trovato oppure non disponi dell\'autorizzazione per visualizzarli.';

  @override
  String foundReels(int count) {
    return 'Trovato ${count} Reels.';
  }

  @override
  String get cannotLoadReelsPublic =>
      'Impossibile caricare Reels. Controlla il profilo o riprova.';

  @override
  String get cannotLoadReelsPrivate =>
      'Impossibile caricare Reels. Si prega di verificare i permessi di visualizzazione.';

  @override
  String get loadingPostsPublic => 'Recupero foto/post...';

  @override
  String get loadingPostsPrivate => 'Caricamento foto/post...';

  @override
  String get noPostsOrPermission =>
      'Nessuna foto/post trovato oppure non sei autorizzato a visualizzarli.';

  @override
  String foundPosts(int count) {
    return 'Trovato ${count} foto/post.';
  }

  @override
  String get cannotLoadPostsPublic =>
      'Impossibile caricare i post. Controlla il profilo o riprova.';

  @override
  String get cannotLoadPostsPrivate =>
      'Impossibile caricare i post. Si prega di verificare i permessi di visualizzazione.';

  @override
  String get cannotLoadMoreContent => 'Impossibile caricare più contenuti.';

  @override
  String get cannotLoadMoreProfile =>
      'Impossibile caricare altro. Inserisci nuovamente il profilo.';

  @override
  String get noMoreNewContent => 'Niente più nuovi contenuti.';

  @override
  String loadedMoreContent(int count) {
    return 'Caricati ${count} altri articoli.';
  }

  @override
  String get loadMoreFailed =>
      'Caricamento di più non riuscito. Per favore riprova.';

  @override
  String get openingReel => 'Apertura Reel...';

  @override
  String get openingPost => 'Messaggio di apertura...';

  @override
  String get cannotOpenContentPermission =>
      'Impossibile aprire questo contenuto. Controlla i permessi di visualizzazione o riprova.';

  @override
  String get downloadingContent => 'Download dei contenuti...';

  @override
  String savedToAlbum(String albumName) {
    return 'Salvato nell\'album ${albumName}.';
  }

  @override
  String savedContentToAlbum(String albumName) {
    return 'Contenuti salvati nell\'album ${albumName}.';
  }

  @override
  String get downloadContentErrorRetry =>
      'Download del contenuto non riuscito. Tocca per riprovare.';

  @override
  String get downloadHistoryCleared =>
      'La cronologia dei download è stata cancellata.';

  @override
  String downloadHistoryItemsRemoved(int count) {
    return 'Rimossi ${count} elementi dalla cronologia.';
  }

  @override
  String get downloadConnectionSlow =>
      'Download non riuscito a causa di una connessione lenta. Toccare per riprovare.';

  @override
  String get downloadNetworkUnavailable =>
      'Impossibile connettersi alla rete/CDN. Controlla la rete e riprova.';

  @override
  String get downloadCancelled => 'Download annullato.';

  @override
  String get downloadGenericError =>
      'Download non riuscito. Tocca per riprovare.';

  @override
  String downloadProgress(String percent) {
    return 'Download di contenuti: ${percent}%';
  }
}
