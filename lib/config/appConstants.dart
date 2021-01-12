class APIConstants {

  static final String baseUrl =
      "https://mobileapi.digitalrequisitions.com/";
  static final String sendMessageToPatientWithFnameLnameAndDOB =
      baseUrl + "CheckPatient?";
  static final String verifyMessageAndGetPatientRecordsEndPoint =
      baseUrl + "Results/";
  static final String userLoginEndPoint = baseUrl + "Token";
  static final String userSignUpEndPoint = baseUrl + "api/Account/Register";
  static final String getLabFaclitiesEndPoint = baseUrl + "api/nova/Facilities";
  static final String userTokenValidationEndPoint =
      baseUrl + "AuthWebApi/api/Values/5";

// Acoording to new requirements
  static final String labIdStatic = "56";
  static final String labEndPoint =
      "https://www.madinasaloon.ae/";

       static final String phoneNumber =
      "03215198085";
}
