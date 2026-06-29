class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String type;
  final bool isRead;
  final String? createdAt;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    this.type = 'general',
    this.isRead = false,
    this.createdAt,
  });

  String get timeAgo {
    if (createdAt == null) return '';
    final now = DateTime.now();
    try {
      final date = DateTime.parse(createdAt!);
      final diff = now.difference(date);
      if (diff.inMinutes < 1) return 'Just now';
      if (diff.inHours < 1) return '${diff.inMinutes}m ago';
      if (diff.inDays < 1) return '${diff.inHours}h ago';
      if (diff.inDays < 7) return '${diff.inDays}d ago';
      return '${diff.inDays ~/ 7}w ago';
    } catch (_) {
      return createdAt ?? '';
    }
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json['id']?.toString() ?? '',
        title: json['title'] as String? ?? '',
        message: json['message'] as String? ?? json['body'] as String? ?? '',
        type: json['type'] as String? ?? 'general',
        isRead: json['is_read'] as bool? ?? false,
        createdAt: json['created_at'] as String? ?? json['timestamp'] as String?,
      );
}
