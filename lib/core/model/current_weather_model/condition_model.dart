import 'dart:convert';

class ConditionModel {
  ConditionModel({
    this.text,
    this.icon,
    this.code,
  });

  final String? text;
  final String? icon;
  final int? code;

  ConditionModel copyWith({
    String? text,
    String? icon,
    int? code,
  }) {
    return ConditionModel(
      text: text ?? this.text,
      icon: icon ?? this.icon,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'icon': icon,
      'code': code,
    };
  }

  factory ConditionModel.fromMap(Map<String, dynamic> map) {
    return ConditionModel(
      text: map['text'],
      icon: map['icon'],
      code: map['code']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ConditionModel.fromJson(String source) =>
      ConditionModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConditionModel &&
        other.text == text &&
        other.icon == icon &&
        other.code == code;
  }

  @override
  int get hashCode => text.hashCode ^ icon.hashCode ^ code.hashCode;

  @override
  String toString() => 'ConditionModel(text: $text, icon: $icon, code: $code)';
}
