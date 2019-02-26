# Copyright (C) 2016 Virgil Security Inc.
#
# Lead Maintainer: Virgil Security Inc. <support@virgilsecurity.com>
#
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
#     (1) Redistributions of source code must retain the above copyright
#     notice, this list of conditions and the following disclaimer.
#
#     (2) Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in
#     the documentation and/or other materials provided with the
#     distribution.
#
#     (3) Neither the name of the copyright holder nor the names of its
#     contributors may be used to endorse or promote products derived from
#     this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ''AS IS'' AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT,
# INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
# STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
# IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
require 'base64'
require 'json'

module Virgil
  module Crypto
    class Bytes < Array
      def self.from_string(str, encoding = StringEncoding::UTF8)
        unless str.is_a?(String)
          raise ArgumentError.new("str is not valid")
        end

        case encoding
        when StringEncoding::UTF8
          new(str.bytes.to_a)
        when StringEncoding::BASE64
          from_base64(str)
        when StringEncoding::HEX
          #todo
        else
          raise ArgumentError.new("encoding is not valid")
        end

      end

      def self.to_string(bytes, encoding = StringEncoding::UTF8)
        unless bytes.is_a?(Array)
          raise ArgumentError.new("bytes is not valid")
        end

        case encoding
        when StringEncoding::UTF8
          new(bytes).to_s
        when StringEncoding::BASE64
          new(bytes).to_base64
        when StringEncoding::HEX
          #todo
        else
          raise ArgumentError.new("encoding is not valid")
        end

      end




      def to_s
        pack('c*')
      end

      def to_json(*a)
        Base64.strict_encode64(to_s).to_json(*a)
      end

      private


      def to_base64
        Base64.strict_encode64(to_s)
      end

      def self.from_base64(source)
        new(Base64.decode64(source).bytes)
      end
    end
  end
end
