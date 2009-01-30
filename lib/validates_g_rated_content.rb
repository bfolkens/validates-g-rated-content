module ValidatesGRatedContent
  BAD_WORDS_REGEXP = /\b(fcuk|fuck|b1tch|bitch|ass|a\$\$|nigger|shit|sh1t|cunt|dick|pussy|cock|tits)\b/i

  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    def validates_g_rated_content_of(*attrs)
      options = { :message => 'contains inappropriate language' }
      options.update(attrs.pop.symbolize_keys) if attrs.last.is_a?(Hash)  # this should use attrs.extract_options!
    
      validates_each attrs do |model, attr, val|
        unless val.nil? || val !~ BAD_WORDS_REGEXP
          model.errors.add(attr, options[:message])
        end
      end
    end
  end
end