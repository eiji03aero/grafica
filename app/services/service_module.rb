module ServiceModule
  module Base
    def execute(*params)
      new(*params).execute
    end
  end
end
