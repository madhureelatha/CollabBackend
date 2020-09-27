class ApiController < ApplicationController
	skip_before_action :verify_authenticity_token
	# Query 3
	# select c.member_count,c.city from cities c , groups g where c.city_id=g.city_id and  g.created between '21-11-2002' AND '30-05-2003';
	def get_trending_member_in_cities
		sql = "select count(g.group_id) as count,c.city from cities c , groups g where c.city_id=g.city_id and  g.created between TO_DATE('"+params["start_time"]+" 00:00:00','DD-MM-YYYY HH24:MI:SS') AND TO_DATE('"+params[end_date]+" 23:59:59','DD-MM-YYYY HH24:MI:SS') group by c.city"
		records= ActiveRecord::Base.connection.exec_query(sql)
		# records_obj = convert_query_to_json records
		render json: records
	end

	def get_categories
		sql = "select category_id,category_name from categories"
		records= ActiveRecord::Base.connection.exec_query(sql)
		render json: records
	end
	# Query 8
	#  Trend : number of active groups(with joined member count > 50 in that year) Vs time(year) ; user enters category_id
	def get_active_groups_count
		sql= "select year, count (group_id) as group_count
		from (select extract(year from joined) as year, group_id, count(member_id)
			  from member_groups natural join groups
			  where category_id = "+params["category_id"]+"
			  group by extract(year from joined),group_id
			  having count(member_id) > 50)
		group by year
		order by year"
		records= ActiveRecord::Base.connection.exec_query(sql)
		render json: records
	end
	
	# def get_trending_member_in_cities 
	# 	sql = "select count(m.member_id),c.state  from members m, member_topics mt , topics t, groups_topics gt ,  groups g, cities c where c.city_id=g.city_id and m.member_id=mt.member_id and mt.topic_id=t.topic_id and t.topic_id= gt.topic_id and g.group_id=gt.group_id and  g.created between '21-11-2002' AND '30-05-2003' and m.member_id in ( select m.member_id  from  members m, member_topics mt , topics t, groups_topics gt , groups g where m.member_id=mt.member_id and mt.topic_id=t.topic_id and t.topic_id= gt.topic_id and g.group_id=gt.group_id and g.created  between '01-09-2002' AND '30-07-2003' )  group by c.state;"
	# 	records= ActiveRecord::Base.connection.exec_query(sql)
	# 	# records_obj = convert_query_to_json records
	# 	render json: records
	# end

	# Query 6	
	def get_widely_spread_groups_member_count
		sql="SELECT g1.group_id
				,max(group_name) AS group_name
				,count(DISTINCT (mg1.member_id)) AS total_members
				,max(g2.count) AS city_count
				,max(g2.member_id_count) as member_count
				,extract(month FROM mg1.joined) AS month1
			FROM groups g1
			JOIN (
				SELECT g.group_id
					,g.city_id
					,count(m.member_id) member_id_count
					,count(DISTINCT (m.city)) AS count
				FROM groups g
				JOIN member_groups mg ON mg.group_id = g.group_id
				JOIN members m ON m.member_id = mg.member_id
				WHERE mg.joined BETWEEN to_date('1-1-"+params["year"]+"', 'MM-DD-YYYY')
						AND to_date('12-31-"+params["year"]+"', 'MM-DD-YYYY')
				GROUP BY g.group_id
					,g.city_id
				ORDER BY count(DISTINCT (m.city)) DESC
					,count(m.member_id) DESC FETCH first 7 rows ONLY
				) g2 ON g1.group_id = g2.group_id
			JOIN member_groups mg1 ON g1.group_id = mg1.group_id
			WHERE extract(year FROM mg1.joined) = "+params["year"]+"
			GROUP BY g1.group_id
				,extract(month FROM mg1.joined)
			ORDER BY city_count desc,member_count desc,g1.group_id
				,month1"
		records=ActiveRecord::Base.connection.exec_query(sql)
		render json: records
	end
	# Query 2
	def get_all_cities
		sql="select city_id,city,country,state,zip from cities where city_id in ( 10001,94101,60601)"  
		records=ActiveRecord::Base.connection.exec_query(sql)
		render json: records
	end

	def get_member_count_per_city_over_time
		sql="select extract(year from joined) as year,topic_id,topic_name,count(member_id) as member_count,sum(count(member_id)) OVER (PARTITION BY extract(year from joined)) total_member_count
		from member_groups natural join groups natural join groups_topics
		where city_id = "+params["location"]+" and 
			(extract(year from joined),topic_id,topic_name) in (select a.year,a.topic_id,a.topic_name
													 from (select extract(year from joined) as year,topic_id,topic_name,count(member_id),
															rank() over (partition by extract(year from joined) order by count(member_id) desc) rank
														   from member_groups natural join groups natural join groups_topics
														   where city_id = "+params["location"]+"
														   group by extract(year from joined),topic_id,topic_name) a
													 where rank <=5)
		group by extract(year from joined),topic_id,topic_name
		order by year"
		records=ActiveRecord::Base.connection.exec_query(sql)
		render json: records
	end


	private 
	def convert_query_to_json result
		resultsArray= []
		result.rows.each do |x|
			object={}
			result.columns.each_with_index do |y,index|
				object[y]=x[index].to_s
			end
			resultsArray.push(object)
		end
		resultsArray
	end
end
