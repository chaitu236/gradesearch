#!/usr/bin/env ruby

require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection(
	adapter: 'sqlite3',
  database: ARGV[0]
)

"db is "+ARGV[0]
"file is "+ARGV[1]

class Grade < ActiveRecord::Base
  attr_accessible :sem, :year, :dept, :courseno, :courseno2, :a, :b, :c, :d, :f, :gpr, :i, :s, :u, :q, :x, :total, :instructor
end

file = File.open(ARGV[1], "r")
#logger.debug('look here')
#logger.debug(file.read)
data = file.read
m = /GRADE DISTRIBUTION REPORT FOR (?<sem>\w+) (?<year>\d+)/
sem = m.match data
data = data.split("\n")

count=0#to keep track of which line we're in
gdata={}
l1=l2=""

line=1

data.each do |i|
	#logger.debug(i)
	if i.length == 0
		next
	end

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
		if(l1 && l2 && sem)
			Grade.create!(:sem=>sem[:sem], :year=>sem[:year].to_i, :dept=>l1[:dept], :courseno=>l1[:courseno].to_i,
						:courseno2=>l1[:courseno2].to_i, :gpr=>l1[:gpr].to_f, :instructor=>URI.unescape(l1[:instructor]).force_encoding('utf-8'), :a=>l2[:a].to_i,
						:b=>l2[:b].to_i, :c=>l2[:c].to_i, :d=>l2[:d].to_i, :f=>l2[:f].to_i, :i=>l2[:i].to_i, :s=>l2[:s].to_i, :u=>l2[:u].to_i,
						:q=>l2[:q].to_i, :x=>l2[:x].to_i, :total=>l2[:total].to_i)
		else
			print "skipped "+line.to_s+"\n"
		end

		count=0
	end
	line=line+1
end
