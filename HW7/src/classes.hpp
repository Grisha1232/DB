#pragma once

#include <string>

namespace orm {

class Country {
public:
    std::string name;
    std::string country_id;
    int area_sqkm;
    int population;
};

class Olympic {
public:
    std::string olympic_id;
    std::string country_id;
    std::string city;
    int year;
    std::string startdate;
    std::string enddate;
};

class Player {
public:
    std::string name;
    std::string player_id;
    std::string country_id;
    std::string birthdate;
};

class Event {
public:
    std::string event_id;
    std::string name;
    std::string eventtype;
    std::string olympic_id;
    int is_team_event;
    int num_players_in_team;
    std::string result_noted_in;
};

class Result {
public:
    std::string event_id;
    std::string player_id;
    std::string medal;
    float result;
};

}  // namespace orm
