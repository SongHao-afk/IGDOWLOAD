// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'IG Downloader';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Salvar';

  @override
  String get login => 'Entrar';

  @override
  String get logout => 'Sair';

  @override
  String get understood => 'Entendi';

  @override
  String get delete => 'Excluir';

  @override
  String get deleteAll => 'Excluir tudo';

  @override
  String get share => 'Compartilhar';

  @override
  String get download => 'Baixar';

  @override
  String get downloadAgain => 'Baixar novamente';

  @override
  String get saved => 'Baixado';

  @override
  String get loading => 'Carregando';

  @override
  String get apply => 'Aplicar';

  @override
  String get frequentProfilesTitle => 'Perfis visualizados recentemente';

  @override
  String get frequentProfilesEmptyTitle => 'Nenhum perfil ainda';

  @override
  String get frequentProfilesEmptyMessage =>
      'Os perfis que você visualizou aparecerão aqui.';

  @override
  String get account => 'Conta';

  @override
  String get downloadHistoryTitle => 'Histórico de downloads';

  @override
  String get downloadHistoryEmptyTitle => 'Nenhum conteúdo ainda';

  @override
  String get downloadHistoryEmptyMessage =>
      'Você não baixou nenhum conteúdo ainda';

  @override
  String selectedCount(int count) {
    return '$count selecionado';
  }

  @override
  String get deleteAllHistoryTitle => 'Excluir todo o histórico?';

  @override
  String get deleteAllHistoryMessage =>
      'Todos os itens do seu histórico de downloads serão removidos do aplicativo.';

  @override
  String deleteSelectedTitle(int count) {
    return 'Excluir $count itens?';
  }

  @override
  String get deleteSelectedOneMessage =>
      'O item selecionado será removido do seu histórico de downloads.';

  @override
  String deleteSelectedManyMessage(int count) {
    return '$count os itens selecionados serão removidos do seu histórico de downloads.';
  }

  @override
  String get deleteOneTitle => 'Excluir este item?';

  @override
  String get deleteOneMessage =>
      'Este item será removido do seu histórico de downloads.';

  @override
  String get cannotShareFileMissing =>
      'Não é possível compartilhar. O arquivo não existe mais neste dispositivo.';

  @override
  String get cannotShareContent => 'Não é possível compartilhar este conteúdo.';

  @override
  String get cannotSaveAgainFileMissing =>
      'Não é possível salvar novamente. O arquivo não existe mais neste dispositivo.';

  @override
  String get savedAgainToGallery => 'Salvo novamente na galeria.';

  @override
  String get cannotSaveAgainContent =>
      'Não é possível salvar este conteúdo novamente.';

  @override
  String get cannotOpenFileMissing =>
      'Não é possível abrir este conteúdo. O arquivo não existe mais neste dispositivo.';

  @override
  String get video => 'Vídeo';

  @override
  String get image => 'Foto';

  @override
  String get content => 'Conteúdo';

  @override
  String get justDownloaded => 'Acabou de baixar';

  @override
  String get heroTitle => 'Baixar conteúdo de Instagram';

  @override
  String get heroConnected => 'Instagram está conectado.';

  @override
  String get heroDescription =>
      'Baixar fotos, rolos e histórias de forma rápida e fácil.';

  @override
  String get downloadByLink => 'Baixar por link';

  @override
  String get invalidLinkTitle => 'Link inválido';

  @override
  String get invalidLinkMessage =>
      'Insira o Instagram link para a postagem, Reel, Story ou vídeo que deseja baixar.';

  @override
  String get downloadByLinkInfo1 =>
      'Use isto quando você já tiver um link para uma postagem Instagram, Reel, Story ou Highlight.';

  @override
  String get downloadByLinkInfo2 =>
      'Cole o link e o aplicativo verificará o conteúdo e permitirá que você faça o download.';

  @override
  String get example => 'Exemplo:';

  @override
  String get enterInstagramLink => 'Insira o Instagram link';

  @override
  String get instagramLinkHint =>
      'https://www.instagram.com/p/... ou /reel/...';

  @override
  String get pasteInstagramLinkHint =>
      'Cole um Instagram link para verificar e baixar o conteúdo desejado.';

  @override
  String get openInstagram => 'Abra Instagram';

  @override
  String get getContent => 'Obter conteúdo';

  @override
  String get explainFeature => 'Explicar recurso';

  @override
  String get downloadFromProfile => 'Baixar do perfil';

  @override
  String get invalidProfileTitle => 'Informações inválidas';

  @override
  String get invalidProfileMessage =>
      'Insira um Instagram nome de usuário ou link de perfil.';

  @override
  String get profileInfo1 =>
      'Use-o quando desejar visualizar e baixar vários itens de uma conta Instagram.';

  @override
  String get profileInfo2 =>
      'Insira um nome de usuário ou link de perfil e escolha os Story, Reels ou postagens que deseja baixar.';

  @override
  String get profileInputLabel => 'Nome de usuário ou link de perfil';

  @override
  String get profileInputHint =>
      'Exemplo: @nomedeusuário ou instagram.com/nomedeusuário';

  @override
  String get profileCardDescription =>
      'Digite um nome de usuário ou link de perfil para visualizar Stories, Reels e postagens para download.';

  @override
  String get story => 'Story';

  @override
  String get storiesHighlights => 'Stories / Highlights';

  @override
  String get reels => 'Reels';

  @override
  String get posts => 'Postagens';

  @override
  String get photosPosts => 'Fotos / Postagens';

  @override
  String get photosVideos => 'Fotos / Vídeos';

  @override
  String get profileSummary => 'Resumo do perfil';

  @override
  String get storyModeHint =>
      'Insira um perfil para visualizar Stories e Highlights para download.';

  @override
  String get reelsModeHint => 'Insira um perfil para visualizar a lista Reels.';

  @override
  String get postsModeHint =>
      'Insira um perfil para ver as postagens para download.';

  @override
  String get storyPopupTitle => 'Baixe Stories do perfil';

  @override
  String get reelsPopupTitle => 'Baixe Reels do perfil';

  @override
  String get postsPopupTitle => 'Baixe postagens do perfil';

  @override
  String get viewStory => 'Ver Story';

  @override
  String get viewReels => 'Ver Reels';

  @override
  String get viewPosts => 'Ver postagens';

  @override
  String get noStoryOrHighlightAll =>
      'Nenhum Story ou Highlight encontrado. Faça login se o conteúdo exigir permissão de visualização.';

  @override
  String get noStoryOrHighlightInput =>
      'Nenhum Story ou Highlight encontrado. Insira um perfil Instagram para verificar.';

  @override
  String get noStoryItems =>
      'Não há conteúdo para exibir ou você não tem permissão para visualizar este item.';

  @override
  String get noFeedAll =>
      'Nenhuma postagem ou vídeo encontrado. Faça login se o conteúdo exigir permissão de visualização.';

  @override
  String get noFeedInput =>
      'Ainda não há conteúdo. Escolha Reels ou Postagens e insira um perfil.';

  @override
  String get endOfContent => 'Você chegou ao final do conteúdo.';

  @override
  String get loadMore => 'Carregar mais';

  @override
  String get loadingMore => 'Carregando mais...';

  @override
  String get cannotShowPostContent =>
      'Não é possível exibir o conteúdo desta postagem.';

  @override
  String get chooseItemToDownload => 'Escolha um item para baixar';

  @override
  String contentCount(int count) {
    return '$count itens';
  }

  @override
  String get chooseThemeColor => 'Escolha a cor do tema';

  @override
  String get themeDefault => 'Padrão';

  @override
  String get themeVivid => 'Vívido';

  @override
  String get themePink => 'Rosa brilhante';

  @override
  String get themeBlue => 'Azul claro';

  @override
  String get themeRed => 'Vermelho';

  @override
  String get themeDark => 'Escuro';

  @override
  String get loginRequiredTitle => 'Login necessário';

  @override
  String get followRequiredTitle => 'Seguir obrigatório';

  @override
  String get followRequiredMessage =>
      'A conta logada não tem permissão para visualizar este conteúdo.';

  @override
  String get downloadSuccessMessage => 'Baixado com sucesso.';

  @override
  String get viewHistory => 'Ver histórico';

  @override
  String get frequentAccessTooltip => 'Acesso frequente';

  @override
  String get recentDownloadsTooltip => 'Downloads recentes';

  @override
  String get changeThemeTooltip => 'Alterar tema';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get themeSettingTitle => 'Tema';

  @override
  String get languageSettingTitle => 'Linguagem';

  @override
  String get chooseLanguageTitle => 'Escolha seu idioma';

  @override
  String get languageVietnameseNative => 'Tiếng Việt';

  @override
  String get languageVietnameseLocal => 'Vietnamese';

  @override
  String get languageEnglishNative => 'English';

  @override
  String get languageEnglishLocal => 'English';

  @override
  String get sessionModeTitle => 'Modo de download';

  @override
  String get sessionPublicMode => 'Public';

  @override
  String get sessionPrivateMode => 'Private';

  @override
  String get sessionPrivateConnected => 'Sua conta Instagram está conectada.';

  @override
  String get sessionPrivatePrompt =>
      'Faça login em Instagram para baixar o conteúdo que sua conta tem permissão para visualizar.';

  @override
  String get sessionPublicPrompt =>
      'Você está baixando conteúdo público sem fazer login.';

  @override
  String get profileReelsListTitle => 'Reel lista de vídeos';

  @override
  String get profilePostsListTitle => 'Lista de fotos/postagens';

  @override
  String get close => 'Fechar';

  @override
  String get instagramHome => 'Instagram casa';

  @override
  String get selectThisContent => 'Selecione este conteúdo';

  @override
  String get manualOpeningInstagram => 'Abrindo Instagram...';

  @override
  String get manualInstruction =>
      'Abra a postagem Reel, Story ou Highlight que deseja baixar e toque em \"Selecionar este conteúdo\".';

  @override
  String get manualPickedContent =>
      'Conteúdo selecionado. Toque em \"Selecionar este conteúdo\" para continuar.';

  @override
  String get manualNoDownloadableContent =>
      'Nenhum conteúdo para download encontrado. Abra uma postagem, Reel, Story ou Highlight.';

  @override
  String get manualCloseToExit =>
      'Para evitar perder o conteúdo selecionado, toque em \"Fechar\" se quiser sair.';

  @override
  String get loginOpeningInstagram => 'Abrindo Instagram... Aguarde.';

  @override
  String get loginInstruction =>
      'Faça login em Instagram e toque em \"Salvar\" para finalizar.';

  @override
  String get loginChecking => 'Verificando login...';

  @override
  String get loginCannotConfirm =>
      'Não é possível confirmar o login.\nFaça login em Instagram e tente salvar novamente.';

  @override
  String get loginSaveError =>
      'Ocorreu um erro ao salvar as informações de login. Por favor, tente novamente.';

  @override
  String get loginLoggingOut => 'Sair...';

  @override
  String get loginLoggedOut =>
      'Você saiu de Instagram.\nFaça login novamente para continuar.';

  @override
  String get loginSuccessPrompt =>
      'Login bem-sucedido.\nToque em \"Salvar\" para finalizar.';

  @override
  String get loginPromptOnLoginPage =>
      'Faça login em Instagram e toque em \"Salvar\" para finalizar.';

  @override
  String get loginPromptSaveBottom =>
      'Se você tiver terminado de fazer login, toque em \"Salvar\" abaixo.';

  @override
  String get loginPageTitle => 'Faça login em Instagram';

  @override
  String get loginOpeningInstagramWithHint =>
      'Abrindo Instagram...\nApós fazer login, toque em \"Salvar\".';

  @override
  String get loginOpenFailed =>
      'Não é possível abrir Instagram.\nVerifique sua conexão com a Internet e tente novamente.';

  @override
  String get profileSavedMissingUsername => 'Perfil salvo sem nome de usuário.';

  @override
  String get openingProfile => 'Abrindo perfil...';

  @override
  String openingUsername(String username) {
    return 'Abrindo @$username...';
  }

  @override
  String foundStoryHighlightsAndPosts(int storyCount, int postCount) {
    return 'Encontrados $storyCount Story/Highlight itens e $postCount postagens.';
  }

  @override
  String get privateModeEnabled => 'Modo habilitado.';

  @override
  String get publicModeEnabled => 'Voltou para o modo Public.';

  @override
  String get cannotConfirmInstagramLogin =>
      'Não é possível confirmar Instagram login. Faça login novamente.';

  @override
  String get instagramConnected => 'Instagram conta conectada.';

  @override
  String get loggingOutInstagram => 'Sair de Instagram...';

  @override
  String get instagramLoggedOut => 'Você saiu de Instagram.';

  @override
  String get instagramLogoutCleanupFailed =>
      'Desconectou-se de Instagram, mas ocorreu um erro ao limpar os dados de login.';

  @override
  String get emptyInstagramLink => 'Por favor, insira um link Instagram.';

  @override
  String get preparingContent => 'Preparando conteúdo...';

  @override
  String get loadingContentWithAccount =>
      'Carregando conteúdo com a conta conectada...';

  @override
  String get cannotFetchContent => 'Não é possível buscar conteúdo.';

  @override
  String get noDownloadableContentFound =>
      'Nenhum conteúdo para download encontrado.';

  @override
  String foundDownloadableContent(int count) {
    return 'Encontrados $count itens para download.';
  }

  @override
  String get fetchContentFailedPublic =>
      'Não é possível buscar conteúdo. Verifique o link ou tente novamente.';

  @override
  String get fetchContentFailedPrivate =>
      'Não é possível buscar conteúdo. Verifique a permissão de visualização ou faça login novamente.';

  @override
  String get emptyProfileInput => 'Insira um perfil Instagram.';

  @override
  String get loadingStoryHighlights => 'Carregando Stories e Highlights...';

  @override
  String get noCurrentStoryOrHighlight =>
      'Nenhuma história atual ou destaque encontrado.';

  @override
  String foundStoryHighlights(int count) {
    return 'Encontrados $count Story/Highlight itens.';
  }

  @override
  String get cannotOpenContent => 'Não é possível abrir este conteúdo.';

  @override
  String openingStoryGroup(String title) {
    return 'Abrindo \"$title\"...';
  }

  @override
  String foundStoryGroupItems(int count, String title) {
    return 'Encontrados $count itens em \"$title\".';
  }

  @override
  String get cannotOpenStoryHighlightLogin =>
      'Não é possível abrir Story ou Highlight. Faça login e tente novamente.';

  @override
  String get cannotOpenStoryHighlightPermission =>
      'Não é possível abrir Story ou Highlight. Por favor, verifique a permissão de visualização.';

  @override
  String get cannotDownloadContent => 'Não é possível baixar este conteúdo.';

  @override
  String get downloadingStory => 'Baixando história...';

  @override
  String savedStoryToAlbum(String albumName) {
    return 'Item de história salvo no álbum $albumName.';
  }

  @override
  String get downloadStoryFailed =>
      'Story download falhou. Por favor, tente novamente.';

  @override
  String get loadingReelsPublic => 'Buscando rolos...';

  @override
  String get loadingReelsPrivate => 'Carregando rolos...';

  @override
  String get noReelsOrPermission =>
      'Nenhum Reel foi encontrado ou você não tem permissão para visualizá-los.';

  @override
  String foundReels(int count) {
    return 'Encontrado $count Reels.';
  }

  @override
  String get cannotLoadReelsPublic =>
      'Não é possível carregar Reels. Verifique o perfil ou tente novamente.';

  @override
  String get cannotLoadReelsPrivate =>
      'Não é possível carregar Reels. Verifique a permissão de visualização.';

  @override
  String get loadingPostsPublic => 'Buscando fotos/postagens...';

  @override
  String get loadingPostsPrivate => 'Carregando fotos/postagens...';

  @override
  String get noPostsOrPermission =>
      'Nenhuma foto/postagem encontrada ou você não tem permissão para visualizá-las.';

  @override
  String foundPosts(int count) {
    return 'Encontrada $count fotos/postagens.';
  }

  @override
  String get cannotLoadPostsPublic =>
      'Não é possível carregar postagens. Verifique o perfil ou tente novamente.';

  @override
  String get cannotLoadPostsPrivate =>
      'Não é possível carregar postagens. Verifique a permissão de visualização.';

  @override
  String get cannotLoadMoreContent => 'Não é possível carregar mais conteúdo.';

  @override
  String get cannotLoadMoreProfile =>
      'Não é possível carregar mais. Por favor, entre no perfil novamente.';

  @override
  String get noMoreNewContent => 'Não há mais conteúdo novo.';

  @override
  String loadedMoreContent(int count) {
    return 'Carregado $count mais itens.';
  }

  @override
  String get loadMoreFailed =>
      'Falha ao carregar mais. Por favor, tente novamente.';

  @override
  String get openingReel => 'Abrindo Reel...';

  @override
  String get openingPost => 'Abrindo postagem...';

  @override
  String get cannotOpenContentPermission =>
      'Não é possível abrir este conteúdo. Verifique a permissão de visualização ou tente novamente.';

  @override
  String get downloadingContent => 'Baixando conteúdo...';

  @override
  String savedToAlbum(String albumName) {
    return 'Salvo no álbum $albumName.';
  }

  @override
  String savedContentToAlbum(String albumName) {
    return 'Conteúdo salvo no álbum $albumName.';
  }

  @override
  String get downloadContentErrorRetry =>
      'Falha no download do conteúdo. Toque para tentar novamente.';

  @override
  String get downloadHistoryCleared => 'Histórico de downloads apagado.';

  @override
  String downloadHistoryItemsRemoved(int count) {
    return 'Itens $count removidos do histórico.';
  }

  @override
  String get downloadConnectionSlow =>
      'O download falhou devido a uma conexão lenta. Toque para tentar novamente.';

  @override
  String get downloadNetworkUnavailable =>
      'Não é possível conectar-se à rede/CDN. Verifique sua rede e tente novamente.';

  @override
  String get downloadCancelled => 'Download cancelado.';

  @override
  String get downloadGenericError =>
      'Falha no download. Toque para tentar novamente.';

  @override
  String downloadProgress(String percent) {
    return 'Baixando conteúdo: $percent%';
  }

  @override
  String get legalLinksTitle => 'Política de Privacidade e Termos';

  @override
  String get termsOfUse => 'Termos de Uso';

  @override
  String get privacyPolicy => 'Política de Privacidade';
}
