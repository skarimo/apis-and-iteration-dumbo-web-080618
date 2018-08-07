require 'rest-client'
require 'json'
require 'pry'


def fetch_url(url)
  response_string = RestClient.get(url)
  response_hash = JSON.parse(response_string)
end

def all_links
  all_links_array = []
  link_s = 'https://swapi.co/api/people/?page='
    for counter in 1..9
      fetched_url = fetch_url(link_s + "#{counter}")
    all_links_array << fetched_url["results"]
    end
    all_links_array
end




def get_character_movies_from_api(character)
  films_array = []
  films_hash = []

  all_links_flaten = all_links.flatten

  all_links_flaten.each do |char|
      if char["name"].downcase == character
        films_array = char["films"]
      end
  end

  films_array.each do |film|
    films_hash << fetch_url(film)
  end
  films_hash
end








def print_movies(films_hash)
  films_hash.each_with_index do |film, idx|
    puts ("#{idx+1}. #{film["title"]}")
  end
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  print_movies(films_array)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
