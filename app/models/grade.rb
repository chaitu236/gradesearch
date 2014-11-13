class Grade < ActiveRecord::Base
	attr_accessible :sem, :year, :dept, :courseno, :courseno2, :a, :b, :c, :d, :f, :gpr, :i, :s, :u, :q, :x, :total, :instructor
end
