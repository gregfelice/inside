class ReportsController < ApplicationController

  def report_data_completeness
    @data_completeness = DataCompleteness.instance.get_data_completeness

    logger.info @data_completeness
  end

  def report_data_entry

    # people with no supervisors
    sql = <<EOF
select p.id, p.name, pa.id
from people p
left join person_associations pa on
p.id = pa.sink_id
where pa.sink_id is null
EOF

    @people_with_no_supervisors = ActiveRecord::Base.connection.execute(sql)

    # people with more than one supervisor
    sql = <<EOF
select p.id, p.name, count(pa.id)
from people p
left join person_associations pa on
p.id = pa.sink_id
where pa.sink_id > 1
group by 1
having count(pa.id) > 1
order by 2 desc
EOF

    @people_with_more_than_one_supervisor = ActiveRecord::Base.connection.execute(sql)

    @people_without_a_group = nil

    @people_without_a_hiring_status = nil



    sql = <<EOF
select p.id, p.name
from people p
where budget is null
EOF

    @people_without_a_budget =  ActiveRecord::Base.connection.execute(sql)



    @people_without_a_hr_status = nil

    @people_without_a_cost_center = nil

    @people_without_a_business_unit = nil

    @people_without_a_seating = nil

    @people_without_a_location_floor = nil

  end

end
