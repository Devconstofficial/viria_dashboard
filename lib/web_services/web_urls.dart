class WebUrls extends _BaseUrl {
  WebUrls._();

  static const String kSignInUrl = "${_BaseUrl._kBaseUrl}/auth/signin";
  static const String kVerifyOTPUrl = "${_BaseUrl._kBaseUrl}/auth/verifyOTP";
  static const String kRefreshTokenUrl =
      "${_BaseUrl._kBaseUrl}/auth/refreshToken";
  static const String kLogoutUrl = "${_BaseUrl._kBaseUrl}/auth/logout";
  static const String kGetBackgroundVideosUrl = "${_BaseUrl._kBaseUrl}/admin/background-videos";
  static const String kDeleteBackgroundVideoUrl = "${_BaseUrl._kBaseUrl}/admin/background-videos";
  static const String kAddBackgroundVideoUrl = "${_BaseUrl._kBaseUrl}/admin/background-videos";
  static const String kGetFontsUrl = "${_BaseUrl._kBaseUrl}/admin/fonts";
  static const String kDeleteFontUrl = "${_BaseUrl._kBaseUrl}/admin/fonts";
  static const String kAddFontUrl = "${_BaseUrl._kBaseUrl}/admin/fonts";
  static const String kAddPredesignedUrl = "${_BaseUrl._kBaseUrl}/admin/presigned-url";

}

abstract class _BaseUrl {
  static const String _kBaseUrl = 'https://backend.viriaa.io';
}
