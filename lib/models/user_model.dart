class UserModel {
  String userId = "";
  String email = "";
  String name = "";
  String profilePicture = "";
  List<String> notificationIds = [];
  List<String> roles = ["user"];
  List<String> refreshTokens = [];
  String? stripeCustomerId;

  UserModel.empty();

  UserModel({
    required this.email,
    required this.name,
    this.profilePicture = "",
    this.notificationIds = const [],
    this.roles = const ["user"],
    this.refreshTokens = const [],
    this.stripeCustomerId,
  });

  UserModel copyWith({
    String? userId,
    String? email,
    String? name,
    String? profilePicture,
    List<String>? notificationIds,
    List<String>? roles,
    List<String>? refreshTokens,
    String? stripeCustomerId,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      profilePicture: profilePicture ?? this.profilePicture,
      notificationIds: notificationIds ?? this.notificationIds,
      roles: roles ?? this.roles,
      refreshTokens: refreshTokens ?? this.refreshTokens,
      stripeCustomerId: stripeCustomerId ?? this.stripeCustomerId,
    )..userId = userId ?? this.userId;
  }

  Map<String, dynamic> toSignUpJson() {
    return {
      "email": email,
      "name": name,
    };
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json["_id"] ?? json["id"] ?? userId;
    email = json["email"] ?? email;
    name = json["name"] ?? name;
    profilePicture = json["profilePicture"] ?? profilePicture;
    notificationIds = (json["notificationIds"] != null)
        ? List<String>.from(json["notificationIds"])
        : notificationIds;
    roles = (json["roles"] != null)
        ? List<String>.from(json["roles"])
        : roles;
    refreshTokens = (json["refreshTokens"] != null)
        ? List<String>.from(json["refreshTokens"])
        : refreshTokens;
    stripeCustomerId = json["stripeCustomerId"];
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": userId,
      "email": email,
      "name": name,
      "profilePicture": profilePicture,
      "notificationIds": notificationIds,
      "roles": roles,
      "refreshTokens": refreshTokens,
      "stripeCustomerId": stripeCustomerId,
    };
  }

  @override
  String toString() {
    return 'UserModel{'
        'userId: $userId, '
        'email: $email, '
        'name: $name, '
        'profilePicture: $profilePicture, '
        'notificationIds: $notificationIds, '
        'roles: $roles, '
        'refreshTokens: $refreshTokens, '
        'stripeCustomerId: $stripeCustomerId'
        '}';
  }
}
