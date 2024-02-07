
4.
   1. Which relations have natural keys?
    IMDB key, theather name.
   2. Is there a risk that any of the natural keys will ever change?
    Theater names, full_names, capacity might change.
   3. Are there any weak entity sets?
    Performance & Ticket.
   4. In which relations do you want to use an invented key. Why?
      Whenever an enitity cannot be uniquely determined from the existing keys
      / weak set
    

6. 
theater(_theater_name_ , capacity)

customer(_username_ , full_name, password)

ticket(_ticket_id_ , /_performance_id_/ , /_username_/)

performance(_performance_id_, date, start_time, /_imdb_key_/, /_theater_name_/)

movie(_imdb_key_, running_time, title, production_year)

7.
Approach 1: Start available seats at capacity and decrement whenever a ticket is sold
Approach 2: Keep track of number of tickets sold and calculate available seats as capacity - # tickets sold when needed.
