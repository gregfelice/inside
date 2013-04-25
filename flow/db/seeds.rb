# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

sql = <<EOF
delete from roles_users
EOF
ActiveRecord::Base.connection.execute(sql)


Role.delete_all

super_admin_role = Role.find_or_create_by_name("SuperAdmin")
super_admin_role.save!

admin_role = Role.find_or_create_by_name("Admin")
admin_role.save!

finance_role = Role.find_or_create_by_name("Finance")
finance_role.save!

staff_role = Role.find_or_create_by_name("Staff")
staff_role.save!


User.delete_all

super_admin = User.create(:email => 'super_admin@nytimes.com', :username => 'super_admin', :password => 'password')
super_admin.roles << super_admin_role
super_admin.save!

admin = User.create(:email => 'admin@nytimes.com', :username => 'admin', :password => 'password')
admin.roles << admin_role
admin.save!

finance = User.create(:email => 'finance@nytimes.com', :username => 'finance', :password => 'password')
finance.roles << finance_role
finance.save!

staff = User.create(:email => 'staff@nytimes.com', :username => 'staff', :password => 'password')
staff.roles << staff_role
staff.save!

