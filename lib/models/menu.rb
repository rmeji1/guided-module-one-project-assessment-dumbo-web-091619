class Menu
  attr_accessor :prompt, :options

  def initialize(prompt:, options:)
    @prompt = prompt
    @options = options
  end
  
end