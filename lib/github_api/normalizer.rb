# encoding: utf-8
      require 'pry'

module Github
  # Deals with normalazing client supplied parameter keys.
  module Normalizer
    # Turns any keys from nested hashes including nested arrays into strings
    #
    def normalize!(params)
      case params
      when Hash
        params.keys.each do |k|
          normalized_key = k.is_a?(Integer) ? k : k.to_s
          params[normalized_key] = params.delete(k)
          normalize!(params[normalized_key])
        end
      when Array
        params.map! do |el|
          normalize!(el)
        end
      end
      params
    end
  end # Normalizer
end # Github
