import './rest_client.dart';

typedef RestClientProvider =
    IRestClient Function({IRestClientOptions? options});

class IRestClient extends IBaseRestClient {}
