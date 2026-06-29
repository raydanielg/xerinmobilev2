class PaymentMethodModel {
  final String id;
  final String type;
  final String provider;
  final String accountName;
  final String accountNumber;
  final bool isDefault;
  final String? expiryDate;

  const PaymentMethodModel({
    required this.id,
    required this.type,
    required this.provider,
    required this.accountName,
    required this.accountNumber,
    this.isDefault = false,
    this.expiryDate,
  });

  String get maskedNumber {
    if (accountNumber.length <= 4) return accountNumber;
    return '****${accountNumber.substring(accountNumber.length - 4)}';
  }

  String get typeLabel {
    switch (type) {
      case 'mobile_money':
        return 'Mobile Money';
      case 'bank':
        return 'Bank Account';
      case 'card':
        return 'Card';
      default:
        return type;
    }
  }

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      PaymentMethodModel(
        id: json['id']?.toString() ?? '',
        type: json['type'] as String? ?? '',
        provider: json['provider'] as String? ?? '',
        accountName: json['account_name'] as String? ?? '',
        accountNumber: json['account_number'] as String? ?? '',
        isDefault: json['is_default'] as bool? ?? false,
        expiryDate: json['expiry_date'] as String?,
      );
}
