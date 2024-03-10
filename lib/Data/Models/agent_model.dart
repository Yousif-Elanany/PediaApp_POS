class AgentModel {
  bool agentDirc;
  int agentType;
  int mainAgentId;
  int companyId;
  int branchID;
  int regionID;
  int userID;
  int boxAcc;
  int glRefID;
  int agentlID;
  int superVID;
  int? vizaID;

AgentModel({
    required this.agentDirc,
    required this.agentType,
    required this.mainAgentId,
    required this.companyId,
    required this.branchID,
    required this.regionID,
    required this.userID,
    required this.boxAcc,
    required this.glRefID,
    required this.agentlID,
    required this.superVID,
    required this.vizaID,
  });

   AgentModel.fromJson(Map<String, dynamic> json):
        agentDirc= json['AgentDirc']== 1 ? true : false,
        agentType= json['AgentType'],
        mainAgentId= json['MainAgentId'],
        companyId= json['CompanyId'],
        branchID= json['BranchID'],
        regionID= json['RegionID'],
        userID= json['UserID'],
        boxAcc= json['BoxAcc'],
        glRefID= json['GlRefID'],
        agentlID= json['AgentlID'],
        superVID= json['SuperVID'],
        vizaID= json['VizaID'];

}
