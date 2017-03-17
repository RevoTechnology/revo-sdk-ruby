module RevoSDK
  class Client
    class Error < StandardError; end
    class ConnectionError < StandardError; end

    module Errors; end

    RESPONSE_STATUSES = {
      10  => 'JSONDecodeError',
      20  => 'OrderIdMissing',
      21  => 'WrongOrderIdFormat',
      22  => 'OrderExists',
      30  => 'WrongOrderSumFormat',
      40  => 'OrderCallbackUrlMissing',
      41  => 'OrderRedirectUrlMissing',
      50  => 'StoreIdMissing',
      51  => 'StoreNotFound',
      60  => 'SignatureMissing',
      61  => 'SignatureWrong',
      100 => 'CannotProcessRequest'
    }

    ERRORS = RESPONSE_STATUSES.inject({}) do |result, error|
      status, name = error
      result[status] = Errors.const_set(name, Class.new(Error))
      result
    end
  end
end
