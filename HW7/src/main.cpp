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

    } catch (const std::exception &e) {
        std::cerr << e.what() << std::endl;
        return 1;
    }

    return 0;
}