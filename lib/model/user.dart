class User {
  final String name;
  final String email;
  final String token;
  final DateTime authTime;
  final DateTime tokenIssueTime;
  final DateTime expirationTime;

  User(this.name, this.email, this.token, this.authTime, this.tokenIssueTime,
      this.expirationTime);
}
