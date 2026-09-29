/// How serious an [Issue] is.
enum Severity {
  /// The plan cannot work as entered.
  error,

  /// The plan is buildable but breaks a recommended limit.
  warning,

  /// Informational only.
  note,
}
