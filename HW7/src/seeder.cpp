#include <iostream>
#include <pqxx/pqxx>
#include <random>
#include <set>
#include <map>

class SimpleSeeder {
public:
    explicit SimpleSeeder(pqxx::connection &connection, unsigned int seed,
                          int countCountry, int countOlympics, int countPlayers, int countEvents, int countResults)
        : connection(connection), generator(seed) {
        addCountries(countCountry);
        addOlympics(countOlympics);
        addPlayers(countPlayers);
        addEvents(countEvents);

        seedCountries();
        seedOlympics();
        seedPlayers();
        seedEvents();
        seedResults(countResults);
    }

    void seedCountries() {
        pqxx::work transaction(connection);

        for (const auto &country : countries) {
            std::string name = country.first;
            std::string countryId = country.second;
            int areaSqkm = generateRandomInt(100000, 1000000);
            int population = generateRandomInt(1000000, 10000000);

            std::string query = "INSERT INTO Countries (name, country_id, area_sqkm, population) "
                                "VALUES ('" + name + "', '" + countryId + "', " +
                                std::to_string(areaSqkm) + ", " + std::to_string(population) + ");";

            transaction.exec(query);
        }

        transaction.commit();
    }

    void seedOlympics() {
        pqxx::work transaction(connection);

        for (const auto &olympicId : olympicIds) {
            std::string countryId = generateRandomCountryId();
            std::string city = generateRandomCity();
            int year = generateRandomInt(1960, 2023);
            std::string startDate = generateRandomDate();
            std::string endDate = generateRandomDate();

            std::string query = "INSERT INTO Olympics (olympic_id, country_id, city, year, startdate, enddate) "
                                "VALUES ('" + olympicId + "', '" + countryId + "', '" + city + "', " +
                                std::to_string(year) + ", '" + startDate + "', '" + endDate + "');";

            transaction.exec(query);
        }

        transaction.commit();
    }

    void seedPlayers() {
        pqxx::work transaction(connection);

        for (const auto &playerId : playerIds) {
            std::string name = "Player" + playerId;
            std::string countryId = generateRandomCountryId();
            std::string birthdate = generateRandomDate();

            std::string query = "INSERT INTO Players (name, player_id, country_id, birthdate) "
                                "VALUES ('" + name + "', '" + playerId + "', '" + countryId + "', '" + birthdate + "');";

            transaction.exec(query);
        }

        transaction.commit();
    }

    void seedEvents() {
        pqxx::work transaction(connection);

        for (const auto &eventId : eventIds) {
            std::string name = "Event" + eventId;
            std::string eventType = generateRandomEventType();
            std::string olympicId = generateRandomOlympicId();
            int isTeamEvent = generateRandomInt(0, 1);
            int numPlayersInTeam = generateRandomInt(1, 10);
            std::string resultNotedIn = generateRandomResultNotedIn();

            std::string query = "INSERT INTO Events (event_id, name, eventtype, olympic_id, is_team_event, "
                                "num_players_in_team, result_noted_in) VALUES ('" + eventId + "', '" + name + "', '" +
                                eventType + "', '" + olympicId + "', " + std::to_string(isTeamEvent) + ", " +
                                std::to_string(numPlayersInTeam) + ", '" + resultNotedIn + "');";

            transaction.exec(query);
        }

        transaction.commit();
    }

    void seedResults(int count) {
        pqxx::work transaction(connection);

        for (int i = 0; i < count; ++i) {
            std::string eventId = generateRandomEventId();
            std::string playerId = generateRandomPlayerId();
            std::string medal = generateRandomMedal();
            float result = generateRandomFloat(0.0, 10.0);

            std::string query = "INSERT INTO Results (event_id, player_id, medal, result) "
                                "VALUES ('" + eventId + "', '" + playerId + "', '" + medal + "', " +
                                std::to_string(result) + ");";

            transaction.exec(query);
        }

        transaction.commit();
    }

private:
    pqxx::connection &connection;
    std::default_random_engine generator;

    std::map<std::string, std::string> countries;
    std::set<std::string> olympicIds;
    std::set<std::string> playerIds;
    std::set<std::string> eventIds;

    void addCountries(int count) {
        for (int i = 0; i < count; ++i) {
            std::string name = "Country" + std::to_string(i);
            std::string countryId = std::to_string(i);
            countries[name] = countryId;
        }
    }

    void addOlympics(int count) {
        for (int i = 0; i < count; i++) {
            olympicIds.insert(std::to_string(i));
        }
    }

    void addPlayers(int count) {
        for (int i = 0; i < count; ++i) {
            playerIds.insert(std::to_string(i));
        }
    }

    void addEvents(int count) {
        for (int i = 0; i < count; ++i) {
            eventIds.insert(std::to_string(i));
        }
    }

    std::string generateRandomCountryId() {
        int count = static_cast<int>(countries.size());
        auto it = std::next(countries.begin(), generateRandomInt(0, count - 1));
        return it->second;
    }

    std::string generateRandomDate() {
        int year = generateRandomInt(1960, 2023);
        int month = generateRandomInt(1, 12);
        int day = generateRandomInt(1, 28); // Примечание: здесь можно уточнить максимальное количество дней в месяце

        return std::to_string(year) + "-" + (month < 10 ? "0" : "") + std::to_string(month) + "-" + (day < 10 ? "0" : "") + std::to_string(day);
    }


    std::string generateRandomCity() {
        return "City" + std::to_string(generateRandomInt(1, 100));
    }

    std::string generateRandomEventType() {
        return "EventType" + std::to_string(generateRandomInt(1, 100));
    }

    std::string generateRandomResultNotedIn() {
        return "ResultNotedIn" + std::to_string(generateRandomInt(1, 100));
    }

    std::string generateRandomMedal() {
        std::vector<std::string> medals = {"GOLD", "SILVER", "BRONZE"};
        std::uniform_int_distribution<int> distribution(0, medals.size() - 1);
        return medals[distribution(generator)];
    }

    int generateRandomInt(int min, int max) {
        std::uniform_int_distribution<int> distribution(min, max);
        return distribution(generator);
    }

    float generateRandomFloat(float min, float max) {
        std::uniform_real_distribution<float> distribution(min, max);
        return distribution(generator);
    }

    std::string generateRandomOlympicId() {
        int count = static_cast<int>(olympicIds.size());
        auto it = std::next(olympicIds.begin(), generateRandomInt(0, count - 1));
        return *it;
    }

    std::string generateRandomPlayerId() {
        int count = static_cast<int>(playerIds.size());
        auto it = std::next(playerIds.begin(), generateRandomInt(0, count - 1));
        return *it;
    }

    std::string generateRandomEventId() {
        int count = static_cast<int>(eventIds.size());
        auto it = std::next(eventIds.begin(), generateRandomInt(0, count - 1));
        return *it;
    }
};
