// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'IG Downloader';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Guardar';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get understood => 'Entendido';

  @override
  String get delete => 'Eliminar';

  @override
  String get deleteAll => 'Eliminar todo';

  @override
  String get share => 'Compartir';

  @override
  String get download => 'Descargar';

  @override
  String get downloadAgain => 'Descargar de nuevo';

  @override
  String get saved => 'Descargado';

  @override
  String get loading => 'Cargando';

  @override
  String get apply => 'Aplicar';

  @override
  String get frequentProfilesTitle => 'Perfiles vistos recientemente';

  @override
  String get frequentProfilesEmptyTitle => 'Aún no hay perfiles';

  @override
  String get frequentProfilesEmptyMessage =>
      'Los perfiles que ha visto aparecerán aquí.';

  @override
  String get account => 'Cuenta';

  @override
  String get downloadHistoryTitle => 'Historial de descargas';

  @override
  String get downloadHistoryEmptyTitle => 'Sin contenido todavía';

  @override
  String get downloadHistoryEmptyMessage =>
      'Tienes aún no has descargado ningún contenido';

  @override
  String selectedCount(int count) {
    return '$count seleccionado';
  }

  @override
  String get deleteAllHistoryTitle => '¿Eliminar todo el historial?';

  @override
  String get deleteAllHistoryMessage =>
      'Todos los elementos de tu historial de descargas se eliminarán de la aplicación.';

  @override
  String deleteSelectedTitle(int count) {
    return '¿Eliminar $count elementos?';
  }

  @override
  String get deleteSelectedOneMessage =>
      'El elemento seleccionado se eliminará de tu historial de descargas.';

  @override
  String deleteSelectedManyMessage(int count) {
    return '$count los elementos seleccionados se eliminarán de tu historial de descargas.';
  }

  @override
  String get deleteOneTitle => '¿Eliminar este elemento?';

  @override
  String get deleteOneMessage =>
      'Este elemento se eliminará de tu historial de descargas.';

  @override
  String get cannotShareFileMissing =>
      'No se puede compartir. El archivo ya no existe en este dispositivo.';

  @override
  String get cannotShareContent => 'No se puede compartir este contenido.';

  @override
  String get cannotSaveAgainFileMissing =>
      'No se puede guardar de nuevo. El archivo ya no existe en este dispositivo.';

  @override
  String get savedAgainToGallery => 'Guardado nuevamente en la galería.';

  @override
  String get cannotSaveAgainContent =>
      'No se puede guardar este contenido nuevamente.';

  @override
  String get cannotOpenFileMissing =>
      'No se puede abrir este contenido. El archivo ya no existe en este dispositivo.';

  @override
  String get video => 'Video';

  @override
  String get image => 'Foto';

  @override
  String get content => 'Contenido';

  @override
  String get justDownloaded => 'Recién descargado';

  @override
  String get heroTitle => 'Descargar contenido de Instagram';

  @override
  String get heroConnected => 'Instagram está conectado.';

  @override
  String get heroDescription =>
      'Descargue fotos, carretes e historias de forma rápida y sencilla.';

  @override
  String get downloadByLink => 'Descargar por enlace';

  @override
  String get invalidLinkTitle => 'Enlace no válido';

  @override
  String get invalidLinkMessage =>
      'Ingrese el enlace Instagram de la publicación, Reel, Story o el video que desea descargar.';

  @override
  String get downloadByLinkInfo1 =>
      'Utilice esto cuando ya tenga un enlace a una publicación Instagram. Reel, Story o Highlight.';

  @override
  String get downloadByLinkInfo2 =>
      'Pegue el enlace y la aplicación verificará el contenido y le permitirá descargarlo.';

  @override
  String get example => 'Ejemplo:';

  @override
  String get enterInstagramLink => 'Ingrese Instagram enlace';

  @override
  String get instagramLinkHint => 'https://www.instagram.com/p/... o /reel/...';

  @override
  String get pasteInstagramLinkHint =>
      'Pegue un enlace Instagram para verificar y descargar el contenido que desee.';

  @override
  String get openInstagram => 'Abrir Instagram';

  @override
  String get getContent => 'Obtener contenido';

  @override
  String get explainFeature => 'Explicar característica';

  @override
  String get downloadFromProfile => 'Descargar desde el perfil';

  @override
  String get invalidProfileTitle => 'Información no válida';

  @override
  String get invalidProfileMessage =>
      'Ingrese un Instagram nombre de usuario o enlace de perfil.';

  @override
  String get profileInfo1 =>
      'Utilice esto cuando desee ver y descargar varios elementos de una Instagram cuenta.';

  @override
  String get profileInfo2 =>
      'Ingrese un nombre de usuario o enlace de perfil, luego elija los Story, Reel o publicaciones que desee descargar.';

  @override
  String get profileInputLabel => 'Nombre de usuario o enlace de perfil';

  @override
  String get profileInputHint =>
      'Ejemplo: @nombredeusuario o instagram.com/nombredeusuario';

  @override
  String get profileCardDescription =>
      'Ingrese un nombre de usuario o enlace de perfil para ver Stories, Reels y publicaciones descargables.';

  @override
  String get story => 'Story';

  @override
  String get storiesHighlights => 'Stories / Highlights';

  @override
  String get reels => 'Reels';

  @override
  String get posts => 'Publicaciones';

  @override
  String get photosPosts => 'Fotos / Publicaciones';

  @override
  String get photosVideos => 'Fotos / Videos';

  @override
  String get profileSummary => 'Resumen de perfil';

  @override
  String get storyModeHint =>
      'Ingrese un perfil para ver Stories descargables y Highlights.';

  @override
  String get reelsModeHint => 'Ingrese un perfil para ver la lista de Reels.';

  @override
  String get postsModeHint =>
      'Ingrese un perfil para ver publicaciones descargables.';

  @override
  String get storyPopupTitle => 'Descargar Stories del perfil';

  @override
  String get reelsPopupTitle => 'Descargar Reels del perfil';

  @override
  String get postsPopupTitle => 'Descargar publicaciones del perfil';

  @override
  String get viewStory => 'Ver Story';

  @override
  String get viewReels => 'Ver Reels';

  @override
  String get viewPosts => 'Ver publicaciones';

  @override
  String get noStoryOrHighlightAll =>
      'No se encontraron Story o Highlight. Inicie sesión si el contenido requiere permiso de visualización.';

  @override
  String get noStoryOrHighlightInput =>
      'No se encontraron Story o Highlight. Ingrese un Instagram perfil para verificar.';

  @override
  String get noStoryItems =>
      'No hay contenido para mostrar o no tiene permiso para ver este elemento.';

  @override
  String get noFeedAll =>
      'No se encontraron publicaciones ni videos. Inicie sesión si el contenido requiere permiso de visualización.';

  @override
  String get noFeedInput =>
      'No hay contenido todavía. Elija Reels o Publicaciones, luego ingrese un perfil.';

  @override
  String get endOfContent => 'Has llegado al final del contenido.';

  @override
  String get loadMore => 'Cargar más';

  @override
  String get loadingMore => 'Cargando más...';

  @override
  String get cannotShowPostContent =>
      'No se puede mostrar el contenido de esta publicación.';

  @override
  String get chooseItemToDownload => 'Elija un elemento para descargar';

  @override
  String contentCount(int count) {
    return '$count artículos';
  }

  @override
  String get chooseThemeColor => 'Elige el color del tema';

  @override
  String get themeDefault => 'Por defecto';

  @override
  String get themeVivid => 'Vívido';

  @override
  String get themePink => 'rosa brillante';

  @override
  String get themeBlue => 'azul claro';

  @override
  String get themeRed => 'Rojo';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get loginRequiredTitle => 'Iniciar sesión requerido';

  @override
  String get followRequiredTitle => 'Seguir requerido';

  @override
  String get followRequiredMessage =>
      'La cuenta que inició sesión no tiene permiso para ver este contenido.';

  @override
  String get downloadSuccessMessage => 'Descargado exitosamente.';

  @override
  String get viewHistory => 'Ver historial';

  @override
  String get frequentAccessTooltip => 'Acceso frecuente';

  @override
  String get recentDownloadsTooltip => 'Descargas recientes';

  @override
  String get changeThemeTooltip => 'Cambiar tema';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get themeSettingTitle => 'Tema';

  @override
  String get languageSettingTitle => 'Idioma';

  @override
  String get chooseLanguageTitle => 'Elige tu idioma';

  @override
  String get languageVietnameseNative => 'Tiếng Việt';

  @override
  String get languageVietnameseLocal => 'Vietnamese';

  @override
  String get languageEnglishNative => 'English';

  @override
  String get languageEnglishLocal => 'English';

  @override
  String get sessionModeTitle => 'Modo de descarga';

  @override
  String get sessionPublicMode => 'Public';

  @override
  String get sessionPrivateMode => 'Private';

  @override
  String get sessionPrivateConnected => 'Su cuenta Instagram está conectada.';

  @override
  String get sessionPrivatePrompt =>
      'Inicie sesión en Instagram para descargar contenido que su cuenta puede ver.';

  @override
  String get sessionPublicPrompt =>
      'Estás descargando contenido público sin iniciar sesión.';

  @override
  String get profileReelsListTitle => 'Reel lista de vídeos';

  @override
  String get profilePostsListTitle => 'Lista de fotos/publicaciones';

  @override
  String get close => 'Cerca';

  @override
  String get instagramHome => 'Instagram casa';

  @override
  String get selectThisContent => 'Seleccione este contenido';

  @override
  String get manualOpeningInstagram => 'Abriendo Instagram...';

  @override
  String get manualInstruction =>
      'Abre la publicación, Reel, Story o Highlight que deseas descargar y luego toca \"Seleccionar este contenido\".';

  @override
  String get manualPickedContent =>
      'Contenido seleccionado. Toca \"Seleccionar este contenido\" para continuar.';

  @override
  String get manualNoDownloadableContent =>
      'No se encontró contenido descargable. Abrir una publicación, Reel, Story o Highlight.';

  @override
  String get manualCloseToExit =>
      'Para evitar perder el contenido seleccionado, toque \"Cerrar\" si desea salir.';

  @override
  String get loginOpeningInstagram => 'Abriendo Instagram... Espere por favor.';

  @override
  String get loginInstruction =>
      'Inicie sesión en Instagram, luego toque \"Guardar\" para finalizar.';

  @override
  String get loginChecking => 'Comprobando inicio de sesión...';

  @override
  String get loginCannotConfirm =>
      'No se puede confirmar el inicio de sesión.\nInicie sesión en Instagram e intente guardar nuevamente.';

  @override
  String get loginSaveError =>
      'Se produjo un error al guardar la información de inicio de sesión. Por favor inténtalo de nuevo.';

  @override
  String get loginLoggingOut => 'Cerrar sesión...';

  @override
  String get loginLoggedOut =>
      'Has cerrado sesión en Instagram.\nPor favor inicie sesión nuevamente para continuar.';

  @override
  String get loginSuccessPrompt =>
      'Inicie sesión exitosamente.\nToca \"Guardar\" para finalizar.';

  @override
  String get loginPromptOnLoginPage =>
      'Inicie sesión en Instagram, luego toque \"Guardar\" para finalizar.';

  @override
  String get loginPromptSaveBottom =>
      'Si ha terminado de iniciar sesión, toque \"Guardar\" a continuación.';

  @override
  String get loginPageTitle => 'Inicia sesión en Instagram';

  @override
  String get loginOpeningInstagramWithHint =>
      'Abriendo Instagram...\nDespués de iniciar sesión, toque \"Guardar\".';

  @override
  String get loginOpenFailed =>
      'No se puede abrir Instagram.\nPor favor verifique su conexión a Internet e inténtelo nuevamente.';

  @override
  String get profileSavedMissingUsername =>
      'Al perfil guardado le falta un nombre de usuario.';

  @override
  String get openingProfile => 'Abriendo perfil...';

  @override
  String openingUsername(String username) {
    return 'Abriendo @$username...';
  }

  @override
  String foundStoryHighlightsAndPosts(int storyCount, int postCount) {
    return 'Se encontraron $storyCount Story/Highlight artículos y $postCount publicaciones.';
  }

  @override
  String get privateModeEnabled => 'Modo Private habilitado.';

  @override
  String get publicModeEnabled => 'Volvió al modo Public.';

  @override
  String get cannotConfirmInstagramLogin =>
      'No se puede confirmar Instagram inicio de sesión. Por favor inicia sesión nuevamente.';

  @override
  String get instagramConnected => 'Instagram cuenta conectada.';

  @override
  String get loggingOutInstagram => 'Cerrar sesión en Instagram...';

  @override
  String get instagramLoggedOut => 'Cerró la sesión de Instagram.';

  @override
  String get instagramLogoutCleanupFailed =>
      'Cerró la sesión de Instagram, pero hubo un error al borrar los datos de inicio de sesión.';

  @override
  String get emptyInstagramLink => 'Ingrese un enlace Instagram.';

  @override
  String get preparingContent => 'Preparando contenido...';

  @override
  String get loadingContentWithAccount =>
      'Cargando contenido con la cuenta conectada...';

  @override
  String get cannotFetchContent => 'No se puede recuperar el contenido.';

  @override
  String get noDownloadableContentFound =>
      'No se encontró contenido descargable.';

  @override
  String foundDownloadableContent(int count) {
    return 'Se encontraron $count elementos descargables.';
  }

  @override
  String get fetchContentFailedPublic =>
      'No se puede recuperar el contenido. Por favor revise el enlace o inténtelo nuevamente.';

  @override
  String get fetchContentFailedPrivate =>
      'No se puede recuperar el contenido. Verifique el permiso de visualización o inicie sesión nuevamente.';

  @override
  String get emptyProfileInput => 'Ingrese un Instagram perfil.';

  @override
  String get loadingStoryHighlights => 'Cargando Stories y Highlights...';

  @override
  String get noCurrentStoryOrHighlight =>
      'No se encontró ninguna historia actual o resaltado.';

  @override
  String foundStoryHighlights(int count) {
    return 'Se encontraron $count Story/Highlight elementos.';
  }

  @override
  String get cannotOpenContent => 'No se puede abrir este contenido.';

  @override
  String openingStoryGroup(String title) {
    return 'Abriendo \"$title\"...';
  }

  @override
  String foundStoryGroupItems(int count, String title) {
    return 'Se encontraron $count elementos en \"$title\".';
  }

  @override
  String get cannotOpenStoryHighlightLogin =>
      'No se puede abrir Story o Highlight. Inicie sesión e inténtelo de nuevo.';

  @override
  String get cannotOpenStoryHighlightPermission =>
      'No se puede abrir Story o Highlight. Verifique el permiso de visualización.';

  @override
  String get cannotDownloadContent => 'No se puede descargar este contenido.';

  @override
  String get downloadingStory => 'Descargando la historia...';

  @override
  String savedStoryToAlbum(String albumName) {
    return 'Elemento de la historia guardado en el álbum $albumName.';
  }

  @override
  String get downloadStoryFailed =>
      'Story falló la descarga. Por favor, inténtelo de nuevo.';

  @override
  String get loadingReelsPublic => 'Obteniendo carretes...';

  @override
  String get loadingReelsPrivate => 'Cargando carretes...';

  @override
  String get noReelsOrPermission =>
      'No se encontraron archivos o no tiene permiso para verlos.';

  @override
  String foundReels(int count) {
    return 'Encontrados $count Reels.';
  }

  @override
  String get cannotLoadReelsPublic =>
      'No se pueden cargar Reels. Por favor revisa el perfil o inténtalo nuevamente.';

  @override
  String get cannotLoadReelsPrivate =>
      'No se pueden cargar Reels. Por favor verifique el permiso de visualización.';

  @override
  String get loadingPostsPublic => 'Obteniendo fotos/publicaciones...';

  @override
  String get loadingPostsPrivate => 'Cargando fotos/publicaciones...';

  @override
  String get noPostsOrPermission =>
      'No se encontraron fotos/publicaciones o no tienes permiso para verlas.';

  @override
  String foundPosts(int count) {
    return 'Se encontraron $count fotos/publicaciones.';
  }

  @override
  String get cannotLoadPostsPublic =>
      'No se pueden cargar publicaciones. Por favor revisa el perfil o inténtalo nuevamente.';

  @override
  String get cannotLoadPostsPrivate =>
      'No se pueden cargar publicaciones. Por favor verifique el permiso de visualización.';

  @override
  String get cannotLoadMoreContent => 'No se puede cargar más contenido.';

  @override
  String get cannotLoadMoreProfile =>
      'No se puede cargar más. Por favor ingresa nuevamente al perfil.';

  @override
  String get noMoreNewContent => 'No más contenido nuevo.';

  @override
  String loadedMoreContent(int count) {
    return 'Se cargaron $count elementos más.';
  }

  @override
  String get loadMoreFailed =>
      'Error al cargar más. Por favor inténtalo de nuevo.';

  @override
  String get openingReel => 'Abriendo Reel...';

  @override
  String get openingPost => 'Publicación de apertura...';

  @override
  String get cannotOpenContentPermission =>
      'No se puede abrir este contenido. Por favor verifique el permiso de visualización o inténtelo nuevamente.';

  @override
  String get downloadingContent => 'Descargando contenido...';

  @override
  String savedToAlbum(String albumName) {
    return 'Guardado en el álbum $albumName.';
  }

  @override
  String savedContentToAlbum(String albumName) {
    return 'Contenido guardado en el álbum $albumName.';
  }

  @override
  String get downloadContentErrorRetry =>
      'La descarga de contenido falló. Toca para intentarlo de nuevo.';

  @override
  String get downloadHistoryCleared => 'Historial de descargas borrado.';

  @override
  String downloadHistoryItemsRemoved(int count) {
    return 'Se eliminaron $count elementos del historial.';
  }

  @override
  String get downloadConnectionSlow =>
      'La descarga falló debido a una conexión lenta. Toca para intentarlo de nuevo.';

  @override
  String get downloadNetworkUnavailable =>
      'No se puede conectar a la red/CDN. Verifique su red e inténtelo nuevamente.';

  @override
  String get downloadCancelled => 'Descarga cancelada.';

  @override
  String get downloadGenericError =>
      'La descarga falló. Toca para intentarlo de nuevo.';

  @override
  String downloadProgress(String percent) {
    return 'Descarga de contenido: $percent%';
  }
}
