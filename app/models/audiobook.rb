class Audiobook < Book
  validate :it_should_has_some_field

  private
    def it_should_has_some_field
      errors[:some_field] << 'not implemented'
    end
end
