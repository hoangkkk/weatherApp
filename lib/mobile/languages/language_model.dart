class Language {
  final int id;
  final String name;
  final String flat;
  final String languageCode;
  Language(this.id, this.name, this.flat, this.languageCode);
  static List<Language> languageList() {
    return <Language>[
      Language(1, "🇻🇳", 'Việt Nam', 'vi'),
      Language(2, "🇬🇧", 'English', 'en'),
    ];
  }
}
