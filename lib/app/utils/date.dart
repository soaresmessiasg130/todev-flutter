DateTime getUtcNow() {
  final date = DateTime.now().toUtc();

  return date;
}

DateTime getUtcTomorow() {
  final tomorrow = getUtcNow().add(const Duration(days: 1));

  return tomorrow;
}
