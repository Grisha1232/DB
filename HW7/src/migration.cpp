#include <iostream>
#include <pqxx/pqxx>

class Migration {
public:
    explicit Migration(pqxx::connection &connection) : connection(connection) {}

    void run() {
        try {
            pqxx::work transaction(connection);

            // Define your schema here
            createCountriesTable(transaction);
            createOlympicsTable(transaction);
            createPlayersTable(transaction);
            createEventsTable(transaction);
            createResultsTable(transaction);

            transaction.commit();
            std::cout << "Migration successful.\n";
        } catch (const std::exception &e) {
            std::cerr << e.what() << std::endl;
        }
    }

private:
    pqxx::connection &connection;

    void createCountriesTable(pqxx::work &transaction) {
        transaction.exec("CREATE TABLE Countries ("
                         "name CHAR(40),"
                         "country_id CHAR(3) UNIQUE,"
                         "area_sqkm INTEGER,"
                         "population INTEGER"
                         ");");
    }

    void createOlympicsTable(pqxx::work &transaction) {
        transaction.exec("CREATE TABLE Olympics ("
                         "olympic_id CHAR(7) UNIQUE,"
                         "country_id CHAR(3),"
                         "city CHAR(50),"
                         "year INTEGER,"
                         "startdate DATE,"
                         "enddate DATE,"
                         "FOREIGN KEY (country_id) REFERENCES Countries(country_id)"
                         ");");
    }

    void createPlayersTable(pqxx::work &transaction) {
        transaction.exec("CREATE TABLE Players ("
                         "name CHAR(40),"
                         "player_id CHAR(10) UNIQUE,"
                         "country_id CHAR(3),"
                         "birthdate DATE,"
                         "FOREIGN KEY (country_id) REFERENCES Countries(country_id)"
                         ");");
    }

    void createEventsTable(pqxx::work &transaction) {
        transaction.exec("CREATE TABLE Events ("
                         "event_id CHAR(7) UNIQUE,"
                         "name CHAR(40),"
                         "eventtype CHAR(20),"
                         "olympic_id CHAR(7),"
                         "is_team_event INTEGER CHECK (is_team_event IN (0, 1)),"
                         "num_players_in_team INTEGER,"
                         "result_noted_in CHAR(100),"
                         "FOREIGN KEY (olympic_id) REFERENCES Olympics(olympic_id)"
                         ");");
    }

    void createResultsTable(pqxx::work &transaction) {
        transaction.exec("CREATE TABLE Results ("
                         "event_id CHAR(7),"
                         "player_id CHAR(10),"
                         "medal CHAR(7),"
                         "result FLOAT,"
                         "FOREIGN KEY (event_id) REFERENCES Events(event_id),"
                         "FOREIGN KEY (player_id) REFERENCES Players(player_id)"
                         ");");
    }
};
