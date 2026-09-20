class RetryPolicy {
  static const int maxRetries = 5;

  static Duration getRetryDelay(int retryCount) {
    return Duration(seconds: 5 * (1 << retryCount));
  }

  static bool canRetry (int retryCount){
    return retryCount < maxRetries;
  }
}
