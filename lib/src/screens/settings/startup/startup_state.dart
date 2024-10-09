enum StartupState {
  always(text: 'دائما'),
  disabled(text: 'ابدا');

  const StartupState({required this.text});
  final String text;
}
