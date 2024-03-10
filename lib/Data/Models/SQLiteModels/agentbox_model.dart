class AgentBoxModel {
  double credit;
  double debit;
  String note;

  AgentBoxModel({
    required this.credit,
    required this.debit,
    required this.note,
  });

  factory AgentBoxModel.fromJson(Map<String, dynamic> json) {
    return AgentBoxModel(
      credit: json['Credit'],
      debit: json['Debit'],
      note: json['Note'],
    );
  }
}