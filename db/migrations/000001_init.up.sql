CREATE TABLE Group(
    id_well SERIAL PRIMARY KEY NOT NULL UNIQUE,
    name_group VARCHAR(32) NOT NULL UNIQUE,
    item VARCHAR(256) NOT NULL,
    number_items INT NOT NULL
);
CREATE TABLE Teachers(
    id_teach SERIAL PRIMARY KEY NOT NULL
    first_name VARCHAR(32) NOT NULL,
    FOREIGN KEY (id_well) REFERENCES(id_well)
)
