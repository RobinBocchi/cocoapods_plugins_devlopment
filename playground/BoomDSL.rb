puts "boom DSL file 加载" + self.to_s

module BoomModule
  class Boom
    # DSL会在BoomModule::Boom类的主体中混入进去
    module DSL
      # module不能new出来，所以实例方法智能用include注入
      def pod
        puts "DSL 方法被调用"
      end
    end
  end
end


