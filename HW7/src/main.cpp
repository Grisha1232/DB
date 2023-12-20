#include <iostream>
#include "seeder.cpp"
#include "migration.cpp"

int main (int argc, char* argv[]) {
    try {
        pqxx::connection connection("dbname=mydb user=postgres password=postgres hostaddr=127.0.0.1 port=5433");
        if (!connection.is_open()) {
            std::cout << "Can't open database" << std::endl;
            return 1;
        }

        Migration mig(connection);
        mig.run();

        unsigned int seed = 123;  // Замените этот seed на тот, который вам нужен
        SimpleSeeder seeder(connection, seed, 100, 10, 100, 50, 200);

        pqxx::work transaction(connection);

        // Задание 1: Олимпийские игры 2004 года
        auto query1_result = transaction.exec(
            "SELECT EXTRACT(YEAR FROM Players.birthdate), "
                   "COUNT(DISTINCT Players.player_id), "
                   "COUNT(DISTINCT CASE WHEN Results.medal = 'Gold' THEN Players.player_id END) " 
            "FROM Olympics "
            "JOIN Events ON Olympics.olympic_id = Events.olympic_id "
            "JOIN Results ON Events.event_id = Results.event_id "
            "JOIN Players ON Results.player_id = Players.player_id " 
            "WHERE Olympics.year = 2004 "
            "GROUP BY EXTRACT(YEAR FROM Players.birthdate) "
            "HAVING COUNT(DISTINCT CASE WHEN Results.medal = 'Gold' THEN Players.player_id END) > 0 "
            "ORDER BY EXTRACT(YEAR FROM Players.birthdate);");

        std::cout << "Query 1 Result:\n";
        for (const auto &row : query1_result) {
            for (const auto &field: row) std::cout <<field.c_str() << '\t';
            std::cout <<"\n";
        }

        // Задание 2: Соревнования с ничьей и двумя золотыми медалями
        auto query2_result = transaction.exec(
            "SELECT DISTINCT e.event_id, e.name "
            "FROM Events e "
            "JOIN Results r ON e.event_id = r.event_id "
            "WHERE e.is_team_event = 0 -- индивидуальные соревнования "
              "AND e.num_players_in_team = 1 -- по одному игроку в каждой команде "
              "AND e.is_team_event = 0 -- индивидуальные соревнования "
              "AND EXISTS ( "
                "SELECT 1 "
                "FROM Results r2 "
                "WHERE r.event_id = r2.event_id "
                  "AND r.player_id <> r2.player_id -- разные игроки "
                  "AND r.medal = 'Gold' AND r2.medal = 'Gold' -- оба игрока выиграли золото);");

        std::cout << "Query 2 Result:\n";
        std::cout << typeid(query2_result).name();
        for (const auto &row : query2_result) {
            for (const auto &field: row) std::cout <<field.c_str() << '\t';
            std::cout <<"\n";
        }

        // Задание 3: Игроки, выигравшие медали на одной Олимпиаде
        auto query3_result = transaction.exec(
            "SELECT Players.name AS player_name "
            "FROM Results "
            "INNER JOIN Players ON Results.player_id = Players.player_id "
            "WHERE medal IS NOT NULL "
            "GROUP BY Players.name");

        std::cout << "Query 3 Result:\n";
        for (const auto &row : query3_result) {
            for (const auto &field: row) std::cout <<field.c_str() << '\t';
            std::cout <<"\n";
        }

        // Задание 4: Страна с наибольшим процентом игроков с гласной в начале имени
        auto query4_result = transaction.exec(
            "SELECT Countries.name, "
            "COUNT(DISTINCT CASE WHEN LOWER(SUBSTRING(Players.name FROM 1 FOR 1)) IN ('a', 'e', 'i', 'o', 'u') THEN Players.player_id END) AS vowel_players, "
            "COUNT(DISTINCT Players.player_id) AS total_players, "
            "COALESCE(COUNT(DISTINCT CASE WHEN LOWER(SUBSTRING(Players.name FROM 1 FOR 1)) IN ('a', 'e', 'i', 'o', 'u') THEN Players.player_id END) * 100.0 / COUNT(DISTINCT Players.player_id), 0) AS percentage "
            "FROM Players "
            "INNER JOIN Countries ON Players.country_id = Countries.country_id "
            "GROUP BY Countries.name "
            "ORDER BY percentage DESC "
            "LIMIT 1");

        std::cout << "Query 4 Result:\n";
        for (const auto &row : query4_result) {
            for (const auto &field: row) std::cout <<field.c_str() << '\t';
            std::cout <<"\n";
        }

        // Задание 5: Топ 5 стран с минимальным соотношением групповых медалей к численности населения (2000 год)
        auto query5_result = transaction.exec(
            "SELECT Countries.name, COALESCE(SUM(CASE WHEN Events.is_team_event = 1 THEN 1 END), 0) AS team_medals, "
            "Countries.population, "
            "COALESCE(SUM(CASE WHEN Events.is_team_event = 1 THEN 1 END) * 100.0 / Countries.population, 0) AS ratio "
            "FROM Countries "
            "INNER JOIN Players ON Countries.country_id = Players.country_id "
            "INNER JOIN Results ON Players.player_id = Results.player_id "
            "INNER JOIN Events ON Results.event_id = Events.event_id "
            "INNER JOIN Olympics ON Events.olympic_id = Olympics.olympic_id "
            "WHERE Olympics.year = 2000 "
            "GROUP BY Countries.name, Countries.population "
            "ORDER BY ratio "
            "LIMIT 5");

        std::cout << "Query 5 Result:\n";
        for (const auto &row : query5_result) {
            for (const auto &field: row) std::cout <<field.c_str() << '\t';
            std::cout <<"\n";
        }

    } catch (const std::exception &e) {
        std::cerr << e.what() << std::endl;
        return 1;
    }

    return 0;
}