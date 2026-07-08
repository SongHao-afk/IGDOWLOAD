// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// The translations for ru (`ru`).
class AppLocalizationsRu extends AppLocalizationsEn {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appName => 'IG Downloader';

  @override
  String get cancel => 'Отмена';

  @override
  String get save => 'Сохранить';

  @override
  String get login => 'Войти';

  @override
  String get logout => 'Выйти';

  @override
  String get understood => 'Понятно';

  @override
  String get delete => 'Удалить';

  @override
  String get deleteAll => 'Удалить все';

  @override
  String get share => 'Поделиться';

  @override
  String get download => 'Загрузить';

  @override
  String get downloadAgain => 'Загрузить снова';

  @override
  String get saved => 'Скачано';

  @override
  String get loading => 'Загрузка';

  @override
  String get apply => 'Применить';

  @override
  String get frequentProfilesTitle => 'Недавно просмотренные профили';

  @override
  String get frequentProfilesEmptyTitle => 'Профилей пока нет';

  @override
  String get frequentProfilesEmptyMessage =>
      'Просмотренные вами профили появятся здесь.';

  @override
  String get account => 'Аккаунт';

  @override
  String get downloadHistoryTitle => 'История загрузок';

  @override
  String get downloadHistoryEmptyTitle => 'Нет контент еще';

  @override
  String get downloadHistoryEmptyMessage =>
      'Вы еще не загрузили какой-либо контент';

  @override
  String selectedCount(int count) {
    return '${count} выбрано';
  }

  @override
  String get deleteAllHistoryTitle => 'Удалить всю историю?';

  @override
  String get deleteAllHistoryMessage =>
      'Все элементы в вашей истории загрузок будут удалены из приложения.';

  @override
  String deleteSelectedTitle(int count) {
    return 'Удалить ${count} элементы?';
  }

  @override
  String get deleteSelectedOneMessage =>
      'Выбранный элемент будет удален из вашей истории загрузок.';

  @override
  String deleteSelectedManyMessage(int count) {
    return '${count} выбранные элементы будут удалены из вашей истории загрузок.';
  }

  @override
  String get deleteOneTitle => 'Удалить этот элемент?';

  @override
  String get deleteOneMessage =>
      'Этот элемент будет удален из вашей истории загрузок.';

  @override
  String get cannotShareFileMissing =>
      'Невозможно поделиться. Файл больше не существует на этом устройстве.';

  @override
  String get cannotShareContent => 'Невозможно поделиться этим содержимым.';

  @override
  String get cannotSaveAgainFileMissing =>
      'Невозможно сохранить снова. Файл больше не существует на этом устройстве.';

  @override
  String get savedAgainToGallery => 'Снова сохранен в галерее.';

  @override
  String get cannotSaveAgainContent =>
      'Невозможно снова сохранить этот контент.';

  @override
  String get cannotOpenFileMissing =>
      'Невозможно открыть этот контент. Файл больше не существует на этом устройстве.';

  @override
  String get video => 'Видео';

  @override
  String get image => 'Фото';

  @override
  String get content => 'Содержимое';

  @override
  String get justDownloaded => 'Только что скачано';

  @override
  String get heroTitle => 'Загрузить содержимое из Instagram';

  @override
  String get heroConnected => 'Instagram подключено.';

  @override
  String get heroDescription =>
      'Загружайте фотографии, ролики и истории быстро и легко.';

  @override
  String get downloadByLink => 'Загрузить по ссылке';

  @override
  String get invalidLinkTitle => 'Недействительная ссылка';

  @override
  String get invalidLinkMessage =>
      'Пожалуйста, введите ссылку Instagram для публикации, Reel, Story или видео, которое вы хотите загрузить.';

  @override
  String get downloadByLinkInfo1 =>
      'Используйте это, если у вас уже есть ссылка на Instagram опубликовать, Reel, Story или Highlight.';

  @override
  String get downloadByLinkInfo2 =>
      'Вставьте ссылку, и приложение проверит контент и позволит вам его загрузить.';

  @override
  String get example => 'Пример:';

  @override
  String get enterInstagramLink => 'Введите Instagram ссылку';

  @override
  String get instagramLinkHint => 'https://www.instagram.com/p/... или /reel/…';

  @override
  String get pasteInstagramLinkHint =>
      'Вставьте ссылку Instagram, чтобы проверить и загрузить нужный контент.';

  @override
  String get openInstagram => 'Открыть Instagram';

  @override
  String get getContent => 'Получить содержание';

  @override
  String get explainFeature => 'Объясните функцию';

  @override
  String get downloadFromProfile => 'Загрузить из профиля';

  @override
  String get invalidProfileTitle => 'Неверная информация';

  @override
  String get invalidProfileMessage =>
      'Пожалуйста, введите Instagram имя пользователя или ссылку на профиль.';

  @override
  String get profileInfo1 =>
      'Используйте это, если вы хотите просмотреть и загрузить несколько элементов из учетной записи Instagram.';

  @override
  String get profileInfo2 =>
      'Введите имя пользователя или ссылку на профиль, затем выберите Story, Reel или сообщения, которые вы хотите загрузить.';

  @override
  String get profileInputLabel => 'Имя пользователя или ссылка на профиль';

  @override
  String get profileInputHint =>
      'Пример: @username или instagram.com/username.';

  @override
  String get profileCardDescription =>
      'Введите имя пользователя или ссылку на профиль, чтобы просмотреть Stories, Reel и публикации, которые можно загрузить.';

  @override
  String get story => 'Story';

  @override
  String get storiesHighlights => 'Stories / Highlight с';

  @override
  String get reels => 'Reelс';

  @override
  String get posts => 'Сообщения';

  @override
  String get photosPosts => 'Фотографии/Сообщения';

  @override
  String get photosVideos => 'Фото/Видео';

  @override
  String get profileSummary => 'Сводка профиля';

  @override
  String get storyModeHint =>
      'Введите профиль, чтобы просмотреть загружаемые Stories и Highlight.';

  @override
  String get reelsModeHint =>
      'Войдите в профиль, чтобы просмотреть список Reel.';

  @override
  String get postsModeHint =>
      'Войдите в профиль, чтобы просмотреть доступные для скачивания сообщения.';

  @override
  String get storyPopupTitle => 'Скачать Stories из профиля';

  @override
  String get reelsPopupTitle => 'Загрузить Reel из профиля';

  @override
  String get postsPopupTitle => 'Скачать посты из профиля';

  @override
  String get viewStory => 'Посмотреть Story';

  @override
  String get viewReels => 'Посмотреть Reel';

  @override
  String get viewPosts => 'Посмотреть сообщения';

  @override
  String get noStoryOrHighlightAll =>
      'Story или Highlight не найдены. Войдите в систему, если контент требует разрешения на просмотр.';

  @override
  String get noStoryOrHighlightInput =>
      'Story или Highlight не найдены. Введите профиль Instagram для проверки.';

  @override
  String get noStoryItems =>
      'Нет контента для отображения, или у вас нет разрешения на просмотр этого элемента.';

  @override
  String get noFeedAll =>
      'Посты и видео не найдены. Войдите в систему, если контент требует разрешения на просмотр.';

  @override
  String get noFeedInput =>
      'Пока нет контента. Выберите Reels или «Сообщения», затем войдите в профиль.';

  @override
  String get endOfContent => 'Вы достигли конца контента.';

  @override
  String get loadMore => 'Загрузить больше';

  @override
  String get loadingMore => 'Загружается еще...';

  @override
  String get cannotShowPostContent =>
      'Невозможно отобразить содержимое этого сообщения.';

  @override
  String get chooseItemToDownload => 'Выберите элемент для загрузки';

  @override
  String contentCount(int count) {
    return '${count} элементы';
  }

  @override
  String get chooseThemeColor => 'Выберите цвет темы';

  @override
  String get themeDefault => 'По умолчанию';

  @override
  String get themeVivid => 'Яркий';

  @override
  String get themePink => 'Глянцево-розовый';

  @override
  String get themeBlue => 'Светло-голубой';

  @override
  String get themeRed => 'Красный';

  @override
  String get themeDark => 'Темный';

  @override
  String get loginRequiredTitle => 'Требуется вход в систему';

  @override
  String get followRequiredTitle => 'Необходимо следовать';

  @override
  String get followRequiredMessage =>
      'Учетная запись, вошедшая в систему, не имеет разрешения на просмотр этого контента.';

  @override
  String get downloadSuccessMessage => 'Загружено успешно.';

  @override
  String get viewHistory => 'Просмотреть история';

  @override
  String get frequentAccessTooltip => 'Частый доступ';

  @override
  String get recentDownloadsTooltip => 'Недавние загрузки';

  @override
  String get changeThemeTooltip => 'Изменить тему';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get themeSettingTitle => 'Тема';

  @override
  String get languageSettingTitle => 'Язык';

  @override
  String get chooseLanguageTitle => 'Выберите язык';

  @override
  String get languageVietnameseNative => 'Tiếng Việt';

  @override
  String get languageVietnameseLocal => 'Vietnamese';

  @override
  String get languageEnglishNative => 'English';

  @override
  String get languageEnglishLocal => 'English';

  @override
  String get sessionModeTitle => 'Режим загрузки';

  @override
  String get sessionPublicMode => 'Public';

  @override
  String get sessionPrivateMode => 'Private';

  @override
  String get sessionPrivateConnected =>
      'Ваша Instagram учетная запись подключена.';

  @override
  String get sessionPrivatePrompt =>
      'Войдите в Instagram, чтобы загрузить контент, который ваша учетная запись может просматривать.';

  @override
  String get sessionPublicPrompt =>
      'Вы загружаете общедоступный контент без входа в систему in.';

  @override
  String get profileReelsListTitle => 'Reel Список видео';

  @override
  String get profilePostsListTitle => 'Список фотографий/сообщений';

  @override
  String get close => 'Закрыть';

  @override
  String get instagramHome => 'Instagram главная страница';

  @override
  String get selectThisContent => 'Выберите этот контент';

  @override
  String get manualOpeningInstagram => 'Открытие Instagram...';

  @override
  String get manualInstruction =>
      'Откройте сообщение, Reel, Story или Highlight, которое вы хотите загрузить, затем нажмите «Выбрать этот контент».';

  @override
  String get manualPickedContent =>
      'Содержимое выбрано. Нажмите «Выбрать этот контент», чтобы продолжить.';

  @override
  String get manualNoDownloadableContent =>
      'Загружаемый контент не найден. Откройте сообщение, Reel, Story или Highlight.';

  @override
  String get manualCloseToExit =>
      'Чтобы не потерять выбранный контент, нажмите «Закрыть», если хотите выйти.';

  @override
  String get loginOpeningInstagram =>
      'Открытие Instagram... Пожалуйста, подождите.';

  @override
  String get loginInstruction =>
      'Войдите в Instagram, затем нажмите «Сохранить», чтобы завершить.';

  @override
  String get loginChecking => 'Проверка входа…';

  @override
  String get loginCannotConfirm =>
      'Невозможно подтвердить вход.\nПожалуйста, войдите в Instagram и повторите попытку сохранения.';

  @override
  String get loginSaveError =>
      'Произошла ошибка при сохранении данных для входа. Пожалуйста, попробуйте еще раз.';

  @override
  String get loginLoggingOut => 'Выход...';

  @override
  String get loginLoggedOut =>
      'Вы вышли из Instagram.\nПожалуйста, войдите еще раз, чтобы продолжить.';

  @override
  String get loginSuccessPrompt =>
      'Вход успешен.\nНажмите «Сохранить», чтобы завершить.';

  @override
  String get loginPromptOnLoginPage =>
      'Войдите в Instagram, затем нажмите «Сохранить», чтобы завершить.';

  @override
  String get loginPromptSaveBottom =>
      'Если вы завершили вход, нажмите «Сохранить» ниже.';

  @override
  String get loginPageTitle => 'Войдите в систему, чтобы Instagram';

  @override
  String get loginOpeningInstagramWithHint =>
      'Открытие Instagram...\nПосле входа нажмите «Сохранить».';

  @override
  String get loginOpenFailed =>
      'Невозможно открыть Instagram.\nПожалуйста, проверьте подключение к Интернету и повторите попытку.';

  @override
  String get profileSavedMissingUsername =>
      'В сохраненном профиле отсутствует имя пользователя.';

  @override
  String get openingProfile => 'Открытие профиля...';

  @override
  String openingUsername(String username) {
    return 'Открытие @${username}...';
  }

  @override
  String foundStoryHighlightsAndPosts(int storyCount, int postCount) {
    return 'Найдены ${storyCount} Story/Highlight элементы и ${postCount} сообщения.';
  }

  @override
  String get privateModeEnabled => 'Private Режим включен.';

  @override
  String get publicModeEnabled => 'Переключен обратно в режим Public.';

  @override
  String get cannotConfirmInstagramLogin =>
      'Невозможно подтвердить вход Instagram. Пожалуйста, войдите снова.';

  @override
  String get instagramConnected => 'Instagram Аккаунт подключен.';

  @override
  String get loggingOutInstagram => 'Выход из Instagram...';

  @override
  String get instagramLoggedOut => 'Вы вышли из Instagram.';

  @override
  String get instagramLogoutCleanupFailed =>
      'Вышли из Instagram, но произошла ошибка при очистке данных для входа.';

  @override
  String get emptyInstagramLink => 'Пожалуйста, введите ссылку Instagram.';

  @override
  String get preparingContent => 'Подготовка контента...';

  @override
  String get loadingContentWithAccount =>
      'Загрузка контента с помощью подключенной учетной записи...';

  @override
  String get cannotFetchContent => 'Невозможно получить контент.';

  @override
  String get noDownloadableContentFound => 'Загружаемый контент не найден.';

  @override
  String foundDownloadableContent(int count) {
    return 'Найдено ${count} загружаемые элементы.';
  }

  @override
  String get fetchContentFailedPublic =>
      'Невозможно получить контент. Пожалуйста, проверьте ссылку или повторите попытку.';

  @override
  String get fetchContentFailedPrivate =>
      'Невозможно получить контент. Пожалуйста, проверьте разрешение на просмотр или войдите снова.';

  @override
  String get emptyProfileInput => 'Пожалуйста, введите профиль Instagram.';

  @override
  String get loadingStoryHighlights => 'Загрузка Stories и Highlights...';

  @override
  String get noCurrentStoryOrHighlight =>
      'Нет текущей истории или основного момента не найдено.';

  @override
  String foundStoryHighlights(int count) {
    return 'Найдено ${count} Story/Highlight элементов.';
  }

  @override
  String get cannotOpenContent => 'Невозможно открыть этот контент.';

  @override
  String openingStoryGroup(String title) {
    return 'Открытие «${title}»…';
  }

  @override
  String foundStoryGroupItems(int count, String title) {
    return 'Найдены ${count} элементы в «${title}».';
  }

  @override
  String get cannotOpenStoryHighlightLogin =>
      'Невозможно открыть Story или Highlight. Пожалуйста, войдите в систему и повторите попытку.';

  @override
  String get cannotOpenStoryHighlightPermission =>
      'Невозможно открыть Story или Highlight. Пожалуйста, проверьте разрешение на просмотр.';

  @override
  String get cannotDownloadContent => 'Невозможно загрузить этот контент.';

  @override
  String get downloadingStory => 'Загрузка истории...';

  @override
  String savedStoryToAlbum(String albumName) {
    return 'Элемент истории сохранен в альбоме ${albumName}.';
  }

  @override
  String get downloadStoryFailed =>
      'Story Не удалось загрузить. Пожалуйста, повторите попытку.';

  @override
  String get loadingReelsPublic => 'Загрузка роликов...';

  @override
  String get loadingReelsPrivate => 'Загрузка роликов...';

  @override
  String get noReelsOrPermission =>
      'Файлы Reel не найдены, или у вас нет разрешения на их просмотр.';

  @override
  String foundReels(int count) {
    return 'Найдено ${count} Reels.';
  }

  @override
  String get cannotLoadReelsPublic =>
      'Невозможно загрузить Reels. Пожалуйста, проверьте профиль или повторите попытку.';

  @override
  String get cannotLoadReelsPrivate =>
      'Невозможно загрузить Reel. Пожалуйста, проверьте разрешение на просмотр.';

  @override
  String get loadingPostsPublic => 'Загрузка фотографий/сообщений...';

  @override
  String get loadingPostsPrivate => 'Загрузка фотографий/сообщений...';

  @override
  String get noPostsOrPermission =>
      'Фотографии/сообщения не найдены, или у вас нет разрешения на их просмотр.';

  @override
  String foundPosts(int count) {
    return 'Найдено ${count} фотографий/сообщений.';
  }

  @override
  String get cannotLoadPostsPublic =>
      'Невозможно загрузить сообщения. Пожалуйста, проверьте профиль или повторите попытку.';

  @override
  String get cannotLoadPostsPrivate =>
      'Невозможно загрузить сообщения. Пожалуйста, проверьте разрешение на просмотр.';

  @override
  String get cannotLoadMoreContent => 'Невозможно загрузить больше контента.';

  @override
  String get cannotLoadMoreProfile =>
      'Невозможно загрузить больше. Пожалуйста, войдите в профиль еще раз.';

  @override
  String get noMoreNewContent => 'Нового контента больше нет.';

  @override
  String loadedMoreContent(int count) {
    return 'Загружено ${count} еще элементов.';
  }

  @override
  String get loadMoreFailed =>
      'Не удалось загрузить больше. Пожалуйста, попробуйте еще раз.';

  @override
  String get openingReel => 'Открытие Reel...';

  @override
  String get openingPost => 'Открытие сообщения...';

  @override
  String get cannotOpenContentPermission =>
      'Невозможно открыть этот контент. Пожалуйста, проверьте разрешение на просмотр или повторите попытку.';

  @override
  String get downloadingContent => 'Загрузка контента...';

  @override
  String savedToAlbum(String albumName) {
    return 'Сохранено в альбом ${albumName}.';
  }

  @override
  String savedContentToAlbum(String albumName) {
    return 'Сохранено содержимое в альбом ${albumName}.';
  }

  @override
  String get downloadContentErrorRetry =>
      'Не удалось загрузить контент. Нажмите, чтобы повторить попытку.';

  @override
  String get downloadHistoryCleared => 'История загрузок очищена.';

  @override
  String downloadHistoryItemsRemoved(int count) {
    return 'Удалены ${count} элементов из истории.';
  }

  @override
  String get downloadConnectionSlow =>
      'Загрузка не удалась из-за медленного соединения. Нажмите, чтобы повторить попытку.';

  @override
  String get downloadNetworkUnavailable =>
      'Невозможно подключиться к сети/CDN. Проверьте свою сеть и повторите попытку.';

  @override
  String get downloadCancelled => 'Загрузка отменена.';

  @override
  String get downloadGenericError =>
      'Загрузка не удалась. Нажмите, чтобы повторить попытку.';

  @override
  String downloadProgress(String percent) {
    return 'Загрузка контента: ${percent}%';
  }
}
