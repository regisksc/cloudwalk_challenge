mixin LastModifiedMixin {
  DateTime? lastModified;

  // ignore: use_setters_to_change_properties
  void markAsModified(DateTime whenModified) {
    lastModified = whenModified;
  }

  String timeSinceLastModified() {
    final now = DateTime.now().toUtc();
    String result = "Just now";
    if (lastModified == null) return result;
    final difference = now.difference(lastModified!);

    if (difference.inHours > 0 && difference.inHours < 24)
      result = "${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago";

    if (difference.inMinutes > 0 && difference.inMinutes < 60)
      result = "${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago";

    if (difference.inDays > 0) result = "${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago";

    return result;
  }
}
