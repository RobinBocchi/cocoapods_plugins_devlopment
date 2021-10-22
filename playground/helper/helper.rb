puts "Helper module外部"
module BoomModule
  puts "Helper module内部, Boom外部"
  # 需要保证类的层级结构一样才能autoload，外部Boom会在使用到UppercaseHelper时候才会过来加载该文件
  class Boom
    puts "Boom内部"
    class UppercaseHelper
      def initialize
        puts "UppercaseHelper initialize"
      end
    end

    class LowercaseHelper
      def initialize
        puts "UppercaseHelper initialize"
      end
    end
  end
end