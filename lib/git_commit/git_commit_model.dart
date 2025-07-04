class GitCommit {
  final bool amend;
  final bool isBreaking;
  final String? type;
  final String? scope;
  final String? message;

  const GitCommit({
    required this.amend,
    required this.isBreaking,
    this.type,
    this.scope,
    this.message,
  });

  @override
  String toString() {
    return 'GitCommit(amend: \$amend, isBreaking: \$isBreaking, type: \$type, scope: \$scope, message: \$message)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GitCommit &&
          runtimeType == other.runtimeType &&
          amend == other.amend &&
          isBreaking == other.isBreaking &&
          type == other.type &&
          scope == other.scope &&
          message == other.message;

  @override
  int get hashCode => amend.hashCode ^ isBreaking.hashCode ^ type.hashCode ^ (scope?.hashCode ?? 0) ^ message.hashCode;
}
