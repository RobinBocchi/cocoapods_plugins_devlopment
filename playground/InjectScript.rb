puts "InjectScript file 加载" + self.to_s

module BoomModule
	class InjectScript
		attr_reader :sandbox #只读属性
		
		def initialize(options)
			@query_params = options.fetch(:query_params)
		end

		def testYield(name)
			info = "info back:" + name
			yield info
		end

		def testYieldButNotEnd(name)
			info = "info back not end:" + name
			yield info
			puts "but not end"
		end

		def testNextUnless(condition)
			# 数组定义
			array = [1, 2, 3, 4, 5, 6]
			# 数组遍历
			array.each do |num|
				# next unless
				next unless num>condition
				# 数字转字符串
				puts "testNextUnless"+condition.to_s+"--"+num.to_s
			end
		end

		def testUnless(num)
			unless num>2
			  puts "num 小于 2"
			else
			  puts "num 大于 2"
			end
		end

		def prepare_command
			command_start = "AAA"
			command_Release = "BBB"
			command_Release << "CCC"
			command_Release << "DDD"
			command_end = "EEE"

			comm_str = command_start
			comm_str << command_Release
			puts comm_str
		end

		def run
			puts "准备远程脚本..."
			puts "http://ibiu.jd.com/api/v1/jdscripts/get_script?#{@query_params}"
			# yield调用测试
			testYield("jiaxiaobin"){ |result|
				puts result
			}
			testYieldButNotEnd("jiaxiaobin"){ |result|
				puts result
			}
			testNextUnless(3)

			path = File.absolute_path('./')
			puts path

			prepare_command
		end
	end
end