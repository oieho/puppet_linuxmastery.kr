# frozen_string_literal: true

#
# validate_x509_rsa_key_pair.rb
#
module Puppet::Parser::Functions
  newfunction(:validate_x509_rsa_key_pair, doc: <<-DOC
    @summary
      Validates a PEM-formatted X.509 certificate and RSA private key using
      OpenSSL.

    Verifies that the certficate's signature was created from the
    supplied key.

    @return
      Fail compilation if any value fails this check.

    ```validate_x509_rsa_key_pair($cert, $key)```

  DOC
  ) do |args|
    require 'openssl'

    NUM_ARGS = 2 unless defined? NUM_ARGS

    unless args.length == NUM_ARGS
      raise Puppet::ParseError,
            "validate_x509_rsa_key_pair(): wrong number of arguments (#{args.length}; must be #{NUM_ARGS})"
    end

    args.each do |arg|
      raise Puppet::ParseError, "#{arg.inspect} is not a string." unless arg.is_a?(String)
    end

    begin
      cert = OpenSSL::X509::Certificate.new(args[0])
    rescue OpenSSL::X509::CertificateError => e
      raise Puppet::ParseError, "Not a valid x509 certificate: #{e}"
    end

    begin
      key = OpenSSL::PKey::RSA.new(args[1])
    rescue OpenSSL::PKey::RSAError => e
      raise Puppet::ParseError, "Not a valid RSA key: #{e}"
    end

    raise Puppet::ParseError, 'Certificate signature does not match supplied key' unless cert.verify(key)
  end
end
