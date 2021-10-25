#!/usr/bin/env ruby

puts "dsl_script 文件加载:" + self.to_s

testInstanceMethod #testInstanceMethod是BoomModule::Boom实例方法，这里和调用上下文有关
pod # pod是定义在BoomDSL.rb文件中的DSL module中的模块方法

module PostInstall
	def load(content)
		puts "dsl_script echo:"+content
	end
end