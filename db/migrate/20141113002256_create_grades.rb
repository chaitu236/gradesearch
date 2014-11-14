class CreateGrades < ActiveRecord::Migration
  def up
		create_table 'grades' do |t|
			t.string 'sem'
			t.integer 'year'
			t.string 'dept'
			t.integer 'courseno'
			t.integer 'courseno2'
			t.integer 'a'
			t.integer 'b'
			t.integer 'c'
			t.integer 'd'
			t.integer 'f'
			t.float 'gpr'
			t.integer 'i'
			t.integer 's'
			t.integer 'u'
			t.integer 'q'
			t.integer 'x'
			t.integer 'total'
			t.string 'instructor'
		end
  end

  def down
		drop_table 'grades'
  end
end
