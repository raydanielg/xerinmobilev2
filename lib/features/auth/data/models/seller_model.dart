class SellerModel {
  final String id;
  final String userId;
  final String businessName;
  final String? businessCategory;
  final String? contactEmail;
  final String? contactPhone;
  final String status;
  final bool agreementAccepted;
  final String createdAt;

  const SellerModel({
    required this.id,
    required this.userId,
    required this.businessName,
    this.businessCategory,
    this.contactEmail,
    this.contactPhone,
    required this.status,
    required this.agreementAccepted,
    required this.createdAt,
  });

  factory SellerModel.fromJson(Map<String, dynamic> json) => SellerModel(
        id: json['id'] as String,
        userId: json['user_id'] as String,
        businessName: json['business_name'] as String,
        businessCategory: json['business_category'] as String?,
        contactEmail: json['contact_email'] as String?,
        contactPhone: json['contact_phone'] as String?,
        status: json['status'] as String,
        agreementAccepted: json['agreement_accepted'] as bool,
        createdAt: json['created_at'] as String,
      );
}
