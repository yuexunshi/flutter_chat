class LanguageBean {
  final String code;
  final String name;
  final String native;

  const LanguageBean({
    required this.code,
    required this.name,
    required this.native,
  });

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'native': native,
    };
  }

  factory LanguageBean.fromMap(Map<String, dynamic> map) {
    return LanguageBean(
      code: map['code'] as String,
      name: map['name'] as String,
      native: map['native'] as String,
    );
  }
}
