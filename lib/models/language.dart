enum Language {
  german('de-DE', 'Deutsch (Deutschland)'),
  englishUs('en-US', 'English (US)'),
  russian('ru-RU', 'Русский'),
  englishUk('en-GB', 'English (UK)'),
  spanish('es-ES', 'Español (España)'),
  french('fr-FR', 'Français (France)'),
  hindi('hi-IN', 'हिंदी'),
  indonesian('id-ID', 'Bahasa Indonesia'),
  italian('it-IT', 'Italiano'),
  japanese('ja-JP', '日本語'),
  korean('ko-KR', '한국어'),
  dutch('nl-NL', 'Nederlands'),
  polish('pl-PL', 'Polski'),
  portuguese('pt-BR', 'Português (Brasil)'),
  chineseCn('zh-CN', '中文 (中国大陆)'),
  chineseHk('zh-HK', '中文 (香港)'),
  chineseTw('zh-TW', '中文 (台灣)');

  final String code;
  final String displayName;

  const Language(this.code, this.displayName);
}
