
6. 
theater(_theater_name_ , capacity)

customer(_username_ , full_name, password)

ticket(_ticket_id_ , /_performance_id_/ , /_username_/)

performance(_performance_id_, date, start_time, /_imdb_key_/, /_theater_name_/)

movie(_imdb_key_, running_time, title, production_year)

7.
Approach 1: Start available seats at capacity and decrement whenever a ticket is sold
Approach 2: Keep track of number of tickets sold and calculate available seats as capacity - # tickets sold when needed.

8.
