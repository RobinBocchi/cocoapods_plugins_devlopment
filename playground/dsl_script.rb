#!/usr/bin/env ruby

puts "dsl_script loaded:" + self.to_s

testInstanceMethod
pod

module PostInstall
	def load(content)
		puts "dsl_script echo:"+content
	end
end