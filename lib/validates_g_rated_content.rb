module ValidatesGRatedContent
  BAD_WORDS_REGEXP = /\b(?:f[uc]{2}k|b[i1]tch|a[s\$]{2}|a[s\$]{2}hole|n[i1]gger|sh[i1]t|cunt|d[i1]ck|pussy|cock|t[i1]ts)\b/i

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