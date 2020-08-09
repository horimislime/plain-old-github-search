class GitHubRepository {
  final String name;
  final String description;
  final String language;
  final int starCount;
  final DateTime updatedAt;
  final String url;

  const GitHubRepository(
      {this.name,
      this.description,
      this.language,
      this.starCount,
      this.updatedAt,
      this.url});

  factory GitHubRepository.fromJson(Map<String, dynamic> json) {
    return GitHubRepository(
      name: json['name'],
      description: json['description'],
      language: json['language'],
      starCount: json['starCount'],
      updatedAt: json['updatedAt'],
      url: json['url'],
    );
  }
}
