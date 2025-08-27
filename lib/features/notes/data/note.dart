import 'dart:ui';

class Note {
  final int id;
  final String title;
  final String content;
  final String category;
  final Color color;
  final DateTime createdAt;

  Note({
    required this.color,
    required this.id,
    required this.title,
    required this.category,
    required this.content,
    required this.createdAt,
  });

  Note copyWith(
      {Color? color,
      int? id,
      String? title,
      String? content,
      DateTime? createdAt,
      String? category}) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      color: color ?? this.color,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory Note.fromJson(Map<String, Object?> json) {
    return Note(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      category: json['category'] as String,
      color: Color(json['color'] as int),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'category': category,
      'color': color.value,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
