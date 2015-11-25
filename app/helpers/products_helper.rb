module ProductsHelper
	def verify_webhook(data, hmac_header)
    digest  = OpenSSL::Digest::Digest.new('sha256')
    calculated_hmac = Base64.encode64(OpenSSL::HMAC.digest(digest, 'e9a934c972bea1863238150e17f7cc0bd849e870280ae2cd7694b47133092640', data)).strip
    calculated_hmac == hmac_header
  end
end
