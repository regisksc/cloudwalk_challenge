mixin LastModifiedMixin {
  DateTime? lastModified;

  void markAsModified() {
    lastModified = DateTime.now();
  }

  String timeSinceLastModified() {
    final now = DateTime.now();
    String result = "Just now";
    if (lastModified == null) return result;
    final difference = now.difference(lastModified!);

    if (difference.inHours > 0) {
      result = "${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago";
    } else if (difference.inMinutes > 0) {
      result = "${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago";
    } else {
      result = "${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago";
    }

    return result;
  }
}
