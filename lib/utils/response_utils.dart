abstract class RepoValidator {}

class RepoSucess extends RepoValidator {}

class RepoFailure extends RepoValidator {
  final String errorMessage;
  RepoFailure(this.errorMessage);

  @override
  String toString() {
    return errorMessage;
  }
}