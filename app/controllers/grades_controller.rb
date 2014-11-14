class GradesController < ApplicationController
	def index
	end

	def search
		data = params[:grade]
		@grade = Grade.new data
		queryf = []
		querys = []
		if data
			if data[:courseno].length > 0
				queryf[queryf.count] = "courseno = ?"
				querys[querys.count] = data[:courseno]
				#@grades = Grade.find_all_by_courseno data[:courseno]
				#logger.debug(@grades)
			end
			if data[:year].length > 0
				queryf[queryf.count] = "year = ?"
				querys[querys.count] = data[:year]
			end
			if data[:sem].length > 0
				queryf[queryf.count] = "sem = ?"
				querys[querys.count] = data[:sem]
			end
			if data[:instructor].length > 0
				queryf[queryf.count] = "instructor like ?"
				querys[querys.count] = "%"+data[:instructor]+"%"
			end

			queryfinalf=''
			queryf.each do |i| queryfinalf+=i+' and ' end

			queryfinalf = queryfinalf[0..-(' and '.length)]

			queryfinal=[queryfinalf]
			queryfinal+=querys

			logger.debug('queryfinal')
			logger.debug(queryfinal)
			@grades = Grade.where(queryfinal)
		end

		#redirect_to grades_path
	end

	def new
	end

	def create
		logger.debug(params)
		file = params[:file]
		logger.debug('look here')
		#logger.debug(file.read)
		data = file.read
		m = /GRADE DISTRIBUTION REPORT FOR (?<sem>\w+) (?<year>\d+)/
		sem = m.match data
		data = data.split("\n")

		count=0#to keep track of which line we're in
		gdata={}
		l1=l2=""

		data.each do |i|
			#logger.debug(i)
			if count==0 && i=~/^\w\w\w\w-\d\d\d-\d\d\d/
				m1 = /^(?<dept>\w+)-(?<courseno>\d+)-(?<courseno2>\d+) (?<gpr>\d+\.\d+) (?<instructor>.+$)/
				l1 = m1.match i
				count=1
			elsif count==1
				count=2
			elsif count==2
				m2 = / (?<a>\d+) (?<b>\d+) (?<c>\d+) (?<d>\d+) (?<f>\d+) (\d+) (?<i>\d+) (?<s>\d+) (?<u>\d+) (?<q>\d+) (?<x>\d+) (?<total>\d+)/
				l2 = m2.match i
				count=3
			elsif count==3
				Grade.create!(:sem=>sem[:sem], :year=>sem[:year].to_i, :dept=>l1[:dept], :courseno=>l1[:courseno].to_i,
								:courseno2=>l1[:courseno2].to_i, :gpr=>l1[:gpr].to_f, :instructor=>l1[:instructor], :a=>l2[:a].to_i, 
								:b=>l2[:b].to_i, :c=>l2[:c].to_i, :d=>l2[:d].to_i, :f=>l2[:f].to_i, :i=>l2[:i].to_i, :s=>l2[:s].to_i, :u=>l2[:u].to_i,
								:q=>l2[:q].to_i, :x=>l2[:x].to_i, :total=>l2[:total].to_i)

				count=0
			end
		end

		redirect_to :back
	end
end
