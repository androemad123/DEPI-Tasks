class Note {
  final String title;
  final String content;
  final String category;
  final DateTime createdAt;

  Note({
    required this.title,
    required  this.category,
    required this.content,
    required this.createdAt,
  });

  Note copyWith({ String? title, String? content, DateTime? createdAt,String? category}) {
    return Note(
      title: title ?? this.title,
      category: category ?? this.category,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
