class Business{
  final String businessId;
  final String businessName;
  final int totalCredit;
  final int totalDebit;

const Business({
  required this.businessId,
  required this.businessName,
  this.totalCredit = 0,
  this.totalDebit = 0,
});

Map<String, dynamic> toJson() => {
  "businessId" : businessId,
  "businessName" : businessName,
  "totalCredit" : totalCredit,
  "totalDebit" : totalDebit
};
}