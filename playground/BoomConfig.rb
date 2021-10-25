puts "BoomConfig file 加载" + self.to_s

module BoomModule
  class BoomConfig
    def version
      @version = "0.1.0"
    end
    attr_writer :version

    # config单例
    def self.instance
      @instance ||= new
    end

    class << self
      attr_writer :instance
    end

    # 为了在其他scope中访问config单例，使用混入模式
    # 定义一个混入，混入后在某个class中可以直接访问config对象
    module Mixin
      def configInstance
        BoomConfig.instance
      end
    end
  end


end