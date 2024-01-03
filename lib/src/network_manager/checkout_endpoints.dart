import 'package:hubtel_merchant_checkout_sdk/src/platform/models/otp_request_body.dart';
import 'package:hubtel_merchant_checkout_sdk/src/platform/models/verify_otp_response.dart';
import 'package:hubtel_merchant_checkout_sdk/src/utils/currency_formatter.dart';

import '../platform/models/models.dart';
import 'api_core.dart';
import 'endpoint_core.dart';

class CheckoutEndPoint with EndPointCore {
  final _basePath = 'checkout.hubtel.com';

  @override
  set apiKey(String apiKey) {
    // TODO: implement apiKey
    super.apiKey = apiKey;
  }

  final String merchantId;

  final String customerMsisdn;

  CheckoutEndPoint(
      {required this.merchantId,
      required this.customerMsisdn,
      required String apiKey}) {
    this.apiKey = apiKey;
  }

  Future<ApiEndPoint> getReceiveMoneyEndpoint(
      MobileMoneyPaymentRequest request) {
    return createEndpoint(
        authority: _basePath,
        path:
            '/api/v1/merchant/$merchantId/unifiedcheckout/receive/mobilemoney/prompt',
        requestType: HttpVerb.POST,
        body: request.toMap());
  }

  Future<ApiEndPoint> getDirectDebitEndPoint(
      MobileMoneyPaymentRequest request) {
    return createEndpoint(
        authority: _basePath,
        path:
            '/api/v1/merchant/$merchantId/unifiedcheckout/receive/mobilemoney/directdebit',
        requestType: HttpVerb.POST,
        body: request.toMap());
  }

  Future<ApiEndPoint> getPreApprovalConfirmEndPoint(
      PreapprovalConfirm request) {
    return createEndpoint(
        authority: _basePath,
        path: 'api/v1/merchant/$merchantId/unifiedcheckout/preapprovalconfirm',
        requestType: HttpVerb.POST,
        body: request.toMap());
  }

  Future<ApiEndPoint> fetchChannels() {
    return createEndpoint(
      authority: _basePath,
      path: 'api/v1/merchant/$merchantId/unifiedcheckout/checkoutchannels',
      requestType: HttpVerb.GET,
    );
  }

  Future<ApiEndPoint> fetchWallets() {
    return createEndpoint(
        authority: _basePath,
        path:
            'api/v1/merchant/$merchantId/unifiedcheckout/wallets/$customerMsisdn',
        requestType: HttpVerb.GET);
  }

  Future<ApiEndPoint> fetchFees(
      {required String channel, required double amount}) {
    return createEndpoint(
        authority: _basePath,
        path: 'api/v1/merchant/$merchantId/unifiedcheckout/feecalculation',
        requestType: HttpVerb.GET,
        body: {'Channel': channel, 'amount': amount.formatDoubleToString()});
  }

  Future<ApiEndPoint> checkStatus({required String clientReference}) {
    return createEndpoint(
        authority: _basePath,
        path: 'api/v1/merchant/$merchantId/unifiedcheckout/statuscheck',
        requestType: HttpVerb.GET,
        body: {'clientReference': clientReference});
  }

  Future<ApiEndPoint> setupDeviceForBankPayment(
      {required SetupPayerAuthRequest requestBody}) {
    return createEndpoint(
        authority: _basePath,
        path: 'api/v1/merchant/$merchantId/cardnotpresent/setup-payerauth',
        requestType: HttpVerb.POST,
        body: requestBody.toMap());
  }

  Future<ApiEndPoint> makeEnrollment({required String transactionId}) {
    return createEndpoint(
        authority: _basePath,
        path:
            'api/v1/merchant/$merchantId/cardnotpresent/enroll-payerauth/$transactionId',
        requestType: HttpVerb.GET);
  }

  Future<ApiEndPoint> setupDeviceForBankPaymentAccessBank(
      {required SetupPayerAuthRequest requestBody}) {
    return createEndpoint(
        authority: _basePath,
        requestType: HttpVerb.POST,
        path:
            '/api/v1/merchant/$merchantId/cardnotpresentunified/initiate-authentication',
        body: requestBody.toMap());
  }

  Future<ApiEndPoint> makeEnrollmentAccessBank(
      {required String transactionId}) {
    return createEndpoint(
        authority: _basePath,
        path:
            '/api/v1/merchant/$merchantId/cardnotpresentunified/authenticate-payer/$transactionId',
        requestType: HttpVerb.POST);
  }

  Future<ApiEndPoint> addMobileWallet({required AddMobileWalletBody request}) {
    return createEndpoint(
        authority: _basePath,
        path: 'api/v1/merchant/$merchantId/unifiedcheckout/addwallet',
        requestType: HttpVerb.POST,
        body: request.toMap());
  }

  Future<ApiEndPoint> checkUserVerification({required String mobileNumber}) {
    return createEndpoint(
      authority: _basePath,
      path:
          'api/v1/merchant/$merchantId/ghanacardkyc/ghanacard-details/$mobileNumber',
      requestType: HttpVerb.GET,
    );
  }

  Future<ApiEndPoint> confirmCardDetails() {
    return createEndpoint(
      authority: _basePath,
      path: '/api/v1/merchant/$merchantId/ghanacardkyc/confirm-ghana-card',
      requestType: HttpVerb.POST,
    );
  }

  Future<ApiEndPoint> intakeUserInput({required IDVerificationBody params}) {
    return createEndpoint(
        authority: _basePath,
        path: 'api/v1/merchant/$merchantId/ghanacardkyc/addghanacard',
        requestType: HttpVerb.GET,
        body: params.toMap());
  }

  Future<ApiEndPoint> otpVerification({required OtpBodyRequest request}) {
    return createEndpoint(
        authority: _basePath,
        path: 'api/v1/merchant/$merchantId/unifiedcheckout/verifyotp',
        requestType: HttpVerb.POST,
        body: request.toMap());
  }

  Future<ApiEndPoint> getOtp({required OtpRequestBody requestBody}) {
    return createEndpoint(
        authority: _basePath,
        path: 'api/v1/merchant/$merchantId/unifiedcheckout/payment-otp',
        requestType: HttpVerb.POST,
        body: requestBody.toMap());
  }

  Future<ApiEndPoint> verifyOtp({required VerifyOtpBody request}) {
    return createEndpoint(
      authority: _basePath,
      path: '/api/v1/merchant/$merchantId/unifiedcheckout/verify-payment-otp',
      requestType: HttpVerb.POST,
      body: request.toMap(),
    );
  }
}
