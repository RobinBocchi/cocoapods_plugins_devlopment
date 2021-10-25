#!/usr/bin/env ruby
#encoding: utf-8
#
#


module BoomModule
	class Boom
		# 引入本地模块
		require File.join(File.dirname(__FILE__), './InjectScript')
		require File.join(File.dirname(__FILE__), './BoomConfig')
		require File.join(File.dirname(__FILE__ ), './BoomDSL')
		autoload :LowercaseHelper, File.join(File.dirname(__FILE__), './helper/helper')
		puts "----------------"

		attr_reader :home_path
		attr_reader :home_path_chomp
		attr_reader :current_path
		attr_reader :instance_variable
		attr_reader :injecter

		include BoomConfig::Mixin
		# 混入DSL
		include BoomModule::Boom::DSL

		def initialize(&block)
			@home_path = `echo "$HOME"`
			puts "$HOME地址：" + @home_path
			@home_path_chomp = @home_path.chomp # chomp移除字符串尾部的分离符
			puts "$HOME地址：" + @home_path
			@current_path = `pwd`
			puts "当前目录地址：" + @home_path
			@instance_variable = "test instance_variable value"
			# 执行传入的block
			instance_eval(&block)
		end

		def self.testClassMethod
			puts "BoomModule::Boom类方法"
		end

		def testInstanceMethod
			puts "实例变量：" + instance_variable
			puts "实例变量：" + @instance_variable
			puts "testInstanceMethod是BoomModule::Boom实例方法"
		end

		def putPath
			puts @home_path
			puts @home_path_chomp
			puts @current_path
		end

		def evalDSL
			# 测试eval执行DSL
			eval(File.new(File.join(File.dirname(__FILE__), 'dsl_script.rb')).read)
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
  puts "创建Boom对象的时候允许外部传入一个block，会在对象初始化完成后执行"
	puts "通过eval方法执行一个注入文件，注意其对上下文变量、方法的引用"
	eval(File.new(File.join(File.dirname(__FILE__),"dsl_script.rb")).read)
	puts "----------------"
end

# 测试类方法调用
# 测试yield回调block 尾随闭包
BoomModule::Boom.dosthForCallBlock do
  puts "执行dosthForCallBlock的尾随闭包"
	puts "----------------"
end

# 测试实例方法调用
#
boom.testInstanceMethod

# 测试类方法和对象方法
# BoomModule::Boom.testClassMethod
# boom.testInstanceMethod
# boom.putPath

# 测试eval方法的执行上下文
# puts "通过eval方法执行一个注入文件"
# boom.evalDSL

# boom.createInjecter
# boom.helperInit
# boom.readConfig




