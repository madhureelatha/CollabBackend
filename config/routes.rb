Rails.application.routes.draw do
	get '/getall', to: 'api#get_all_tests'
	get '/get_stats', to: 'api#get_stats'
	get '/get_cat', to:'api#get_cat'
	get '/get_cat2', to:'api#get_cat2'
	get '/get_trending_member_in_cities',to:'api#get_trending_member_in_cities'
	get '/get_active_groups_count', to: 'api#get_active_groups_count'
	get '/get_categories', to:'api#get_categories'
	get '/get_widely_spread_groups_member_count', to:'api#get_widely_spread_groups_member_count'
	get '/get_all_cities',to:'api#get_all_cities'
	get '/get_member_count_per_city_over_time', to:'api#get_member_count_per_city_over_time'
	# get '/get_cat2', to:'api#get_cat2'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
