class PriceFormatter {
  static const double _usdToTzs = 2500;

  static String fromUsd(String usdPrice) {
    final value = double.tryParse(
          usdPrice.replaceAll('\$', '').replaceAll(',', '').trim(),
        ) ??
        0;
    final tzs = (value * _usdToTzs).round();
    return 'TSh ${_formatNumber(tzs)}';
  }

  static double toTzsNumber(String usdPrice) {
    final value = double.tryParse(
          usdPrice.replaceAll('\$', '').replaceAll(',', '').trim(),
        ) ??
        0;
    return value * _usdToTzs;
  }

  static String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]},',
        );
  }
}
