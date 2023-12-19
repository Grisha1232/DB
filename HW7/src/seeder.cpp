#include <iostream>
#include <pqxx/pqxx>
#include <random>

class SimpleSeeder {
public:
    explicit SimpleSeeder(pqxx::connection &connection, unsigned int seed)
        : connection(connection), generator(seed) {}

    void seedPlayers(int count) {
        pqxx::work transaction(connection);

        for (int i = 0; i < count; ++i) {
            std::string name = generateRandomName();
            std::string gender = generateRandomGender();
            std::string country = generateRandomCountry();
            std::string birthdate = generateRandomBirthdate();

            std::string query = "INSERT INTO players (player_name, gender, country, birthdate) "
                                "VALUES ('" + name + "', '" + gender + "', '" + country + "', '" + birthdate + "');";

            transaction.exec(query);
        }

        transaction.commit();
    }

    void seedOlympics(int count) {
        pqxx::work transaction(connection);

        for (int i = 0; i < count; ++i) {
            int year = generateRandomYear();
            std::string season = generateRandomSeason();
            std::string country = generateRandomCountry();
            std::string city = generateRandomCity();

            std::string query = "INSERT INTO olympics (year, season, country, city) "
                                "VALUES (" + std::to_string(year) + ", '" + season + "', '" + country + "', '" + city + "');";

            transaction.exec(query);
        }

        transaction.commit();
    }

    void seedEvents(int count) {
        pqxx::work transaction(connection);

        for (int i = 0; i < count; ++i) {
            std::string sport = generateRandomSport();
            std::string eventName = generateRandomEventName();
            std::string location = generateRandomCity();
            std::string scheduledTime = generateRandomScheduledTime();

            std::string query = "INSERT INTO events (sport, event_name, location, scheduled_time) "
                                "VALUES ('" + sport + "', '" + eventName + "', '" + location + "', '" + scheduledTime + "');";

            transaction.exec(query);
        }

        transaction.commit();
    }

    void seedMedals(int count) {
        pqxx::work transaction(connection);

        for (int i = 0; i < count; ++i) {
            int playerId = generateRandomInt(1, 100);  // Assuming you have 100 players
            int eventId = generateRandomInt(1, 50);    // Assuming you have 50 events
            std::string medalType = generateRandomMedalType();
            bool tie = generateRandomBool();

            std::string query = "INSERT INTO medals (player_id, event_id, medal_type, tie) "
                                "VALUES (" + std::to_string(playerId) + ", " + std::to_string(eventId) + ", '"
                                + medalType + "', " + (tie ? "TRUE" : "FALSE") + ");";

            transaction.exec(query);
        }

        transaction.commit();
    }

private:
    pqxx::connection &connection;
    std::default_random_engine generator;

    // Вспомогательные функции для генерации случайных данных
    std::string generateRandomName() {
        // Реализация может быть заменена на свою
        return "Player" + std::to_string(generateRandomInt(1, 1000));
    }

    std::string generateRandomGender() {
        return generateRandomBool() ? "Male" : "Female";
    }

    std::string generateRandomCountry() {
        // Реализация может быть заменена на свою
        return "Country" + std::to_string(generateRandomInt(1, 50));
    }

    std::string generateRandomBirthdate() {
        // Реализация может быть заменена на свою
        return "2000-01-01";
    }

    int generateRandomYear() {
        return generateRandomInt(1960, 2022);
    }

    std::string generateRandomSeason() {
        return generateRandomBool() ? "Summer" : "Winter";
    }

    std::string generateRandomCity() {
        // Реализация может быть заменена на свою
        return "City" + std::to_string(generateRandomInt(1, 20));
    }

    std::string generateRandomSport() {
        // Реализация может быть заменена на свою
        return "Sport" + std::to_string(generateRandomInt(1, 10));
    }

    std::string generateRandomEventName() {
        // Реализация может быть заменена на свою
        return "Event" + std::to_string(generateRandomInt(1, 100));
    }

    std::string generateRandomScheduledTime() {
        // Реализация может быть заменена на свою
        return "2023-01-01T12:00:00";
    }

    std::string generateRandomMedalType() {
        return generateRandomBool() ? "GOLD" : (generateRandomBool() ? "SILVER" : "BRONZE");
    }

    bool generateRandomBool() {
        std::bernoulli_distribution distribution(0.5);
        return distribution(generator);
    }

    int generateRandomInt(int min, int max) {
        std::uniform_int_distribution<int> distribution(min, max);
        return distribution(generator);
    }
};

int main() {
    try {
        pqxx::connection connection("dbname=mydb user=postgres password=postgres hostaddr=127.0.0.1 port=5433");
        if (!connection.is_open()) {
            std::cout << "Can't open database" << std::endl;
            return 1;
        }

        unsigned int seed = 123;  // Замените этот seed на тот, который вам нужен
        SimpleSeeder seeder(connection, seed);

        // Генерация фейковых данных
        seeder.seedPlayers(100);
        seeder.seedOlympics(10);
        seeder.seedEvents(50);
        seeder.seedMedals(200);

    } catch (const std::exception &e) {
        std::cerr << e.what() << std::endl;
        return 1;
    }

    return 0;
}
