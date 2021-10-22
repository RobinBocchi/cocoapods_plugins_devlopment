#!/usr/bin/env ruby
#
#
module BoomModule
	class Boom

		require File.join(File.dirname(__FILE__), './InjectScript')
		require File.join(File.dirname(__FILE__), './BoomConfig')
		require File.join(File.dirname(__FILE__ ), './BoomDSL')
		autoload :LowercaseHelper, File.join(File.dirname(__FILE__), './helper/helper')

		attr_reader :home_path
		attr_reader :home_path_chomp
		attr_reader :current_path
		attr_reader :injecter

		include BoomConfig::Mixin
		include BoomModule::Boom::DSL

		def initialize(&block)
			@home_path = `echo "$HOME"`
			@home_path_chomp = @home_path.chomp
			@current_path = `pwd`
			# 执行传入的block
			instance_eval(&block)
		end

		def self.testClassMethod
			puts "BoomModule::Boom类方法"
		end

		def testInstanceMethod
			puts "BoomModule::Boom实例方法"
		end

		def putPath
			puts @home_path
			puts @home_path_chomp
			puts @current_path
		end

		def evalDSL
			# 测试eval执行DSL
			eval(File.new("./dsl_script.rb").read)
		end

		def createInjecter
			@injecter = BoomModule::InjectScript.new({
																					:query_params => "git=#{`biugit -git url "/Users/jiaxiaobin/biu/JAPIAppModule"`}"
																				})
		end

		def injecterRun
			@injecter.run
		end

		def helperInit
			LowercaseHelper.new
		end

		def readConfig
			puts configInstance.version
		end

		def self.dosthForCallBlock
			puts "dosth"
			yield if block_given?
		end
	end

end


boom = BoomModule::Boom.new do
  puts "创建Boom对象的时候允许外部传入一个block"
	eval(File.new("./dsl_script.rb").read)
end

# 测试yield回调block 尾随闭包
BoomModule::Boom.dosthForCallBlock do
  puts "执行dosthForCallBlock回调"
end
# 测试类方法和对象方法
# BoomModule::Boom.testClassMethod
# boom.testInstanceMethod
# boom.putPath

# 测试eval方法的执行上下文
# boom.evalDSL
# eval(File.new("./dsl_script.rb").read)

# boom.createInjecter
# boom.helperInit
# boom.readConfig




